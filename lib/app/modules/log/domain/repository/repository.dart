import 'package:appweb/app/core/error/failures.dart';
import 'package:appweb/app/modules/log/data/model/log_model.dart';
import 'package:dartz/dartz.dart';

abstract class Repository {
  Future<Either<Failure, String>> set({required LogModel params});
  Future<Either<Failure, List<LogModel>>> get({required LogModel params});
  Future<Either<Failure, bool>> delete({required LogModel params});
  Future<Either<Failure, bool>> send({required String params});
}
