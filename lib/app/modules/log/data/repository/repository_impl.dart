import 'package:appweb/app/core/error/failures.dart';
import 'package:appweb/app/modules/log/data/datassource/datasource.dart';
import 'package:appweb/app/modules/log/data/model/log_model.dart';
import 'package:appweb/app/modules/log/domain/repository/repository.dart';
import 'package:dartz/dartz.dart';

class RepositoryImpl implements Repository {
  final Datasource datasource;
  RepositoryImpl({
    required this.datasource,
  });

  @override
  Future<Either<Failure, String>> set({required LogModel params}) async {
    try {
      final result = await datasource.set(params: params);

      return Right(result);
    } on Exception {
      return Left(throw Left(ServerFailure()));
    }
  }

  @override
  Future<Either<Failure, List<LogModel>>> get(
      {required LogModel params}) async {
    try {
      final result = await datasource.get(params: params);

      return Right(result);
    } on Exception {
      return Left(throw Left(ServerFailure()));
    }
  }

  @override
  Future<Either<Failure, bool>> delete({required LogModel params}) async {
    try {
      final result = await datasource.delete(params: params);

      return Right(result);
    } on Exception {
      return Left(throw Left(ServerFailure()));
    }
  }

  @override
  Future<Either<Failure, bool>> send({required String params}) async {
    try {
      final result = await datasource.send(params: params);

      return Right(result);
    } on Exception {
      return Left(throw Left(ServerFailure()));
    }
  }
}
