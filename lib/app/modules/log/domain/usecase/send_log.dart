import 'package:appweb/app/core/error/failures.dart';
import 'package:appweb/app/modules/Core/domain/usecase/usecase.dart';
import 'package:appweb/app/modules/log/domain/repository/repository.dart';
import 'package:dartz/dartz.dart';

class SendLog implements UseCase<bool, String> {
  final Repository repository;

  SendLog({required this.repository});

  @override
  Future<Either<Failure, bool>> call(String params) async {
    return repository.send(params: params);
  }
}
