import 'package:dartz/dartz.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:transly/app/local_storage.dart';
import 'package:transly/data/failture.dart';
import 'package:transly/data/remote_data_source.dart';
import 'package:transly/domain/models.dart';
import 'package:transly/domain/repository.dart';

class RepositoryImpl implements Repository {
  final RemoteDataSource _remoteDataSource;

  UserModel? _cachedAuthStatus;

  RepositoryImpl(this._remoteDataSource);

  // =========================================================================
  // TERMS
  // =========================================================================

  @override
  Future<Either<Failture, TermModel>> getDailyTerm() async {
    try {
      final result = await _remoteDataSource.getDailyTerm();
      return Right(result);
    } on Failture catch (failture) {
      return Left(failture);
    }
  }

  @override
  Future<Either<Failture, List<TermModel>>> searchTerms(String query) async {
    try {
      final result = await _remoteDataSource.searchTerms(query);
      return Right(result);
    } on Failture catch (failture) {
      return Left(failture);
    }
  }

  @override
  Future<Either<Failture, List<TermModel>>> getTermsByCategory(
    String category,
  ) async {
    try {
      final result = await _remoteDataSource.getTermsByCategory(category);
      return Right(result);
    } on Failture catch (failture) {
      return Left(failture);
    }
  }

  @override
  Future<Either<Failture, TermModel>> getTermById(int id) async {
    try {
      final result = await _remoteDataSource.getTermById(id);
      return Right(result);
    } on Failture catch (failture) {
      return Left(failture);
    }
  }

  @override
  Future<Either<Failture, List<TermModel>>> getAllTerms({
    int page = 0,
    int pageSize = 20,
  }) async {
    try {
      final result = await _remoteDataSource.getAllTerms(
        page: page,
        pageSize: pageSize,
      );
      return Right(result);
    } on Failture catch (failture) {
      return Left(failture);
    }
  }

  @override
  Future<Either<Failture, int>> getTotalTermsCount() async {
    try {
      final result = await _remoteDataSource.getTotalTermsCount();
      return Right(result);
    } on Failture catch (failture) {
      return Left(failture);
    }
  }

  // =========================================================================
  // AUTH
  // =========================================================================

  @override
  UserModel get currentAuthStatus =>
      _cachedAuthStatus ?? const UserModel(id: '', isAnonymous: true);

  @override
  Future<Either<Failture, UserModel>> initializeAuth() async {
    try {
      final user = _remoteDataSource.currentUser;

      if (user != null) {
        final status = _statusFromUser(user);
        _cachedAuthStatus = status;

        // Ensure user row exists in DB (best-effort)
        try {
          await _remoteDataSource.ensureUserExists(
            user.id,
            email: user.email,
            displayName: user.userMetadata?['full_name'] as String?,
            photoUrl: user.userMetadata?['avatar_url'] as String?,
          );
        } catch (_) {}

        return Right(status);
      }

      // No session → sign in anonymously
      final anonUser = await _remoteDataSource.signInAnonymously();
      final status = UserModel(id: anonUser.id, isAnonymous: true);
      _cachedAuthStatus = status;
      return Right(status);
    } on Failture catch (failture) {
      return Left(failture);
    }
  }

  @override
  Future<Either<Failture, UserModel>> signInWithGoogle() async {
    try {
      // Store local favorites before sign-in (in case user switches account)
      final localFavorites = LocalAppStorage.getFavorites();
      final localFavoriteIds = localFavorites.map((t) => t.id).toList();

      final user = await _remoteDataSource.signInWithGoogle();

      final status = _statusFromUser(user);
      _cachedAuthStatus = status;

      // Ensure user row exists
      try {
        await _remoteDataSource.ensureUserExists(
          user.id,
          email: user.email,
          displayName: user.userMetadata?['full_name'] as String?,
          photoUrl: user.userMetadata?['avatar_url'] as String?,
        );
      } catch (_) {}

      // Merge local favorites into remote
      try {
        await _mergeFavoritesAfterAuth(
          userId: user.id,
          localFavoriteIds: localFavoriteIds,
        );
      } catch (_) {}

      return Right(status);
    } on Failture catch (failture) {
      return Left(failture);
    }
  }

  @override
  Future<Either<Failture, void>> signOut() async {
    try {
      await _remoteDataSource.signOut();
      _cachedAuthStatus = null;
      // Re-initialize as anonymous
      await initializeAuth();
      return const Right(null);
    } on Failture catch (failture) {
      return Left(failture);
    }
  }

  @override
  Future<void> syncFavorites() async {
    final status = _cachedAuthStatus;
    if (status == null || status.id.isEmpty) return;

    try {
      final remoteFavoriteIds = await _remoteDataSource.getFavoriteTermIds(
        status.id,
      );

      final localFavorites = LocalAppStorage.getFavorites();
      final localFavoriteIds = localFavorites.map((t) => t.id).toSet();

      // Local → Remote (upload missing)
      final missingRemotely =
          localFavoriteIds
              .where((id) => !remoteFavoriteIds.contains(id))
              .toList();

      if (missingRemotely.isNotEmpty) {
        await _remoteDataSource.syncFavorites(status.id, missingRemotely);
      }
    } catch (_) {
      // Sync is best-effort — don't break the app
    }
  }

  // =========================================================================
  // AUTH HELPERS
  // =========================================================================

  Future<void> _mergeFavoritesAfterAuth({
    required String userId,
    required List<int> localFavoriteIds,
  }) async {
    if (localFavoriteIds.isEmpty) return;

    final remoteFavoriteIds = await _remoteDataSource.getFavoriteTermIds(
      userId,
    );

    final toUpload =
        localFavoriteIds
            .where((id) => !remoteFavoriteIds.contains(id))
            .toList();

    if (toUpload.isNotEmpty) {
      await _remoteDataSource.syncFavorites(userId, toUpload);
    }
  }

  UserModel _statusFromUser(User user) {
    final isGoogle =
        user.appMetadata['provider'] == 'google' ||
        (user.identities?.any((i) => i.provider == 'google') ?? false);

    return UserModel(
      id: user.id,
      email: user.email,
      displayName: user.userMetadata?['full_name'] as String?,
      photoUrl: user.userMetadata?['avatar_url'] as String?,
      isAnonymous: !isGoogle,
    );
  }


}
