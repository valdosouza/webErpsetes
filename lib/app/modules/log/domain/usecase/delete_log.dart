import 'package:appweb/app/core/error/failures.dart';
import 'package:appweb/app/modules/Core/domain/usecase/usecase.dart';
import 'package:appweb/app/modules/log/data/model/log_model.dart';
import 'package:appweb/app/modules/log/domain/repository/repository.dart';
import 'package:dartz/dartz.dart';

class DeleteLog implements UseCase<bool, LogModel> {
  final Repository repository;

  DeleteLog({required this.repository});

  @override
  Future<Either<Failure, bool>> call(LogModel params) async {
    return repository.delete(params: params);
  }
}
