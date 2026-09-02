import 'package:dartz/dartz.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:medlex/app/local_storage.dart';
import 'package:medlex/data/failure.dart';
import 'package:medlex/data/remote_data_source.dart';
import 'package:medlex/domain/models.dart';
import 'package:medlex/domain/repository.dart';
import 'package:medlex/data/error_handler.dart';

class RepositoryImpl implements Repository {
  final RemoteDataSource _remoteDataSource;

  UserModel? _cachedAuthStatus;

  RepositoryImpl(this._remoteDataSource);

  // =========================================================================
  // TERMS
  // =========================================================================

  @override
  Future<Either<Failure, TermModel>> getDailyTerm() async {
    try {
      final result = await _remoteDataSource.getDailyTerm();
      return Right(result);
    } on Failure catch (failure) {
      return Left(failure);
    }
  }

  @override
  Future<Either<Failure, List<TermModel>>> searchTerms(String query) async {
    try {
      final result = await _remoteDataSource.searchTerms(query);
      return Right(result);
    } on Failure catch (failure) {
      return Left(failure);
    }
  }

  @override
  Future<Either<Failure, List<TermModel>>> getTermsByCategory(
    String category,
  ) async {
    try {
      final result = await _remoteDataSource.getTermsByCategory(category);
      return Right(result);
    } on Failure catch (failure) {
      return Left(failure);
    }
  }

  @override
  Future<Either<Failure, TermModel>> getTermById(int id) async {
    try {
      final result = await _remoteDataSource.getTermById(id);
      return Right(result);
    } on Failure catch (failure) {
      return Left(failure);
    }
  }

  @override
  Future<Either<Failure, List<TermModel>>> getAllTerms({
    int page = 0,
    int pageSize = 20,
  }) async {
    try {
      final result = await _remoteDataSource.getAllTerms(
        page: page,
        pageSize: pageSize,
      );
      return Right(result);
    } on Failure catch (failure) {
      return Left(failure);
    }
  }

  @override
  Future<Either<Failure, List<TermModel>>> getFavorites() async {
    try {
      final localFavorites = LocalAppStorage.getFavorites();
      return Right(localFavorites);
    } catch (_) {
      return Left(DataSource.unknown.toFailure());
    }
  }

  @override
  Future<Either<Failure, int>> getTotalTermsCount() async {
    try {
      final result = await _remoteDataSource.getTotalTermsCount();
      return Right(result);
    } on Failure catch (failure) {
      return Left(failure);
    }
  }

  @override
  Future<Either<Failure, List<TermModel>>> getRandomTerms(int count) async {
    try {
      final result = await _remoteDataSource.getRandomTerms(count);
      return Right(result);
    } on Failure catch (failure) {
      return Left(failure);
    }
  }

  @override
  Future<Either<Failure, List<TermModel>>> getTermsByIds(List<int> ids) async {
    try {
      final result = await _remoteDataSource.getTermsByIds(ids);
      return Right(result);
    } on Failure catch (failure) {
      return Left(failure);
    }
  }

  // =========================================================================
  // AUTH
  // =========================================================================

  @override
  UserModel get currentAuthStatus =>
      _cachedAuthStatus ?? const UserModel(id: '', isAnonymous: true);

  @override
  Future<Either<Failure, UserModel>> initializeAuth() async {
    try {
      final user = _remoteDataSource.currentUser;

      if (user != null) {
        final status = _statusFromUser(user);
        _cachedAuthStatus = status;
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

      final anonUser = await _remoteDataSource.signInAnonymously();
      final status = UserModel(id: anonUser.id, isAnonymous: true);
      _cachedAuthStatus = status;
      return Right(status);
    } on Failure catch (failure) {
      return Left(failure);
    }
  }

  @override
  Future<Either<Failure, UserModel>> signInWithGoogle() async {
    try {
      final localFavorites = LocalAppStorage.getFavorites();
      final localFavoriteIds = localFavorites.map((t) => t.id).toList();

      final user = await _remoteDataSource.signInWithGoogle();

      final status = _statusFromUser(user);
      _cachedAuthStatus = status;

      try {
        await _remoteDataSource.ensureUserExists(
          user.id,
          email: user.email,
          displayName: user.userMetadata?['full_name'] as String?,
          photoUrl: user.userMetadata?['avatar_url'] as String?,
        );
      } catch (_) {}

      try {
        await _mergeFavoritesAfterAuth(
          userId: user.id,
          localFavoriteIds: localFavoriteIds,
        );
      } catch (_) {}

      return Right(status);
    } on Failure catch (failure) {
      return Left(failure);
    }
  }

  @override
  Future<Either<Failure, void>> signOut() async {
    try {
      await _remoteDataSource.signOut();
      _cachedAuthStatus = null;
      await initializeAuth();
      return const Right(null);
    } on Failure catch (failure) {
      return Left(failure);
    }
  }

  /// The signed-in user's id, or null when nobody is signed in.
  String? get _signedInUserId {
    final id = currentAuthStatus.id;
    return id.isEmpty ? null : id;
  }

  @override
  Future<Either<Failure, void>> addFavoriteRemotely(int termId) async {
    final userId = _signedInUserId;
    if (userId == null) return const Right(null);
    try {
      await _remoteDataSource.addFavorite(userId, termId);
      return const Right(null);
    } on Failure catch (failure) {
      return Left(failure);
    }
  }

  @override
  Future<Either<Failure, void>> removeFavoriteRemotely(int termId) async {
    final userId = _signedInUserId;
    if (userId == null) return const Right(null);
    try {
      await _remoteDataSource.removeFavorite(userId, termId);
      return const Right(null);
    } on Failure catch (failure) {
      return Left(failure);
    }
  }

  @override
  Future<Either<Failure, List<TermModel>>> reconcileFavorites() async {
    final userId = _signedInUserId;
    if (userId == null) return Right(LocalAppStorage.getFavorites());

    try {
      final remoteIds = (await _remoteDataSource.getFavoriteTermIds(
        userId,
      )).toSet();
      final localIds = LocalAppStorage.getFavorites().map((t) => t.id).toSet();

      for (final termId in remoteIds.difference(localIds)) {
        final term = await _remoteDataSource.getTermById(termId);
        await LocalAppStorage.addFavorite(term);
      }

      final missingRemotely = localIds.difference(remoteIds).toList();
      if (missingRemotely.isNotEmpty) {
        await _remoteDataSource.syncFavorites(userId, missingRemotely);
      }

      return Right(LocalAppStorage.getFavorites());
    } on Failure catch (failure) {
      return Left(failure);
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

      final missingRemotely =
          localFavoriteIds
              .where((id) => !remoteFavoriteIds.contains(id))
              .toList();

      if (missingRemotely.isNotEmpty) {
        await _remoteDataSource.syncFavorites(status.id, missingRemotely);
      }
    } catch (_) {}
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
 @override
  Future<Either<Failure, void>> removeAllUserFavorites() async {
    try {
      await _remoteDataSource.removeAllFavorites();
      return Right(null);
    }on Failure catch (e) {
      return Left(e);
    }
  }
}
