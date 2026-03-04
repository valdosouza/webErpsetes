import 'package:appweb/app/core/error/failures.dart';
import 'package:appweb/app/modules/Core/domain/usecase/usecase.dart';
import 'package:appweb/app/modules/log/data/model/log_model.dart';
import 'package:appweb/app/modules/log/domain/repository/repository.dart';
import 'package:dartz/dartz.dart';

class SetLog implements UseCase<String, LogModel> {
  final Repository repository;

  SetLog({required this.repository});

  @override
  Future<Either<Failure, String>> call(LogModel params) async {
    return repository.set(params: params);
  }
}
