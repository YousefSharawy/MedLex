import 'package:dartz/dartz.dart';
import 'package:transly/data/failture.dart';
import 'package:transly/domain/models.dart';

abstract class Repository {
  Future<Either<Failture, TermModel>> getDailyTerm();
  Future<Either<Failture, List<TermModel>>> searchTerms(String query);
  Future<Either<Failture, List<TermModel>>> getTermsByCategory(String category);
  Future<Either<Failture, TermModel>> getTermById(int id);
  Future<Either<Failture, List<TermModel>>> getAllTerms({
    int page = 0,
    int pageSize = 20,
  });
  Future<Either<Failture, int>> getTotalTermsCount();
  Future<Either<Failture, UserModel>> initializeAuth();
  Future<Either<Failture, UserModel>> signInWithGoogle();
  Future<Either<Failture, void>> signOut();
  Future<void> syncFavorites();
  UserModel get currentAuthStatus;
}
