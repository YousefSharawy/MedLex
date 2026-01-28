import 'package:dartz/dartz.dart';
import 'package:transly/data/failture.dart';
import 'package:transly/domain/models.dart';

abstract class Repository {
  Future<Either<Failture, TermModel>> getDailyTerm();
  Future<Either<Failture, List<TermModel>>> searchTerms(String query);
  Future<Either<Failture, List<TermModel>>> getTermsByCategory(String category);
  Future<Either<Failture, List<String>>> getCategories();
  Future<Either<Failture, TermModel>> getTermById(int id);
}
