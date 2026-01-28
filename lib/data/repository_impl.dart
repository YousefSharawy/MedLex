import 'package:dartz/dartz.dart';
import 'package:transly/data/failture.dart';
import 'package:transly/data/remote_data_source.dart';
import 'package:transly/domain/models.dart';
import 'package:transly/domain/repository.dart';

class RepositoryImpl implements Repository {
  final RemoteDataSource _remoteDataSource;

  RepositoryImpl(this._remoteDataSource);

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
  Future<Either<Failture, List<TermModel>>> getTermsByCategory(String category) async {
    try {
      final result = await _remoteDataSource.getTermsByCategory(category);
      return Right(result);
    } on Failture catch (failture) {
      return Left(failture);
    }
  }

  @override
  Future<Either<Failture, List<String>>> getCategories() async {
    try {
      final result = await _remoteDataSource.getCategories();
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
}