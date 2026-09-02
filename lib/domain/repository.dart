import 'package:dartz/dartz.dart';
import 'package:medlex/data/failure.dart';
import 'package:medlex/domain/models.dart';

abstract class Repository {
  // ── Terms ──
  Future<Either<Failure, TermModel>> getDailyTerm();
  Future<Either<Failure, List<TermModel>>> searchTerms(String query);
  Future<Either<Failure, List<TermModel>>> getTermsByCategory(String category);
  Future<Either<Failure, TermModel>> getTermById(int id);
  Future<Either<Failure, List<TermModel>>> getAllTerms({
    int page = 0,
    int pageSize = 20,
  });
  Future<Either<Failure, List<TermModel>>> getFavorites();
  Future<Either<Failure, int>> getTotalTermsCount();
  Future<Either<Failure, List<TermModel>>> getRandomTerms(int count);
  Future<Either<Failure, List<TermModel>>> getTermsByIds(List<int> ids);
  Future<Either<Failure, void>> removeAllUserFavorites();

  // ── Favorites ──
  /// Mirrors a locally-added favorite to the signed-in user's account.
  /// A no-op (Right) when nobody is signed in.
  Future<Either<Failure, void>> addFavoriteRemotely(int termId);

  /// Mirrors a locally-removed favorite to the signed-in user's account.
  /// A no-op (Right) when nobody is signed in.
  Future<Either<Failure, void>> removeFavoriteRemotely(int termId);

  /// Reconciles local and remote favorites in both directions and returns the
  /// merged local set. A no-op returning the local favorites when nobody is
  /// signed in.
  Future<Either<Failure, List<TermModel>>> reconcileFavorites();


  // ── Auth ──
  Future<Either<Failure, UserModel>> initializeAuth();
  Future<Either<Failure, UserModel>> signInWithGoogle();
  Future<Either<Failure, void>> signOut();
  Future<void> syncFavorites();
  UserModel get currentAuthStatus;

}
