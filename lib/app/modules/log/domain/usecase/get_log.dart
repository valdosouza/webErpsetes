import 'package:appweb/app/core/error/failures.dart';
import 'package:appweb/app/modules/Core/domain/usecase/usecase.dart';
import 'package:appweb/app/modules/log/data/model/log_model.dart';
import 'package:appweb/app/modules/log/domain/repository/repository.dart';
import 'package:dartz/dartz.dart';

class GetLog implements UseCase<List<LogModel>, LogModel> {
  final Repository repository;

  GetLog({required this.repository});

  @override
  Future<Either<Failure, List<LogModel>>> call(LogModel params) async {
    return repository.get(params: params);
  }
}
