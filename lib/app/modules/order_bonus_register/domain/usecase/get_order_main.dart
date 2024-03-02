import 'package:appweb/app/core/error/exceptions.dart';
import 'package:appweb/app/core/error/failures.dart';
import 'package:appweb/app/modules/Core/domain/usecase/usecase.dart';
import 'package:appweb/app/modules/order_bonus_register/data/model/order_main_model.dart';
import 'package:appweb/app/modules/order_bonus_register/domain/repository/respository.dart';
import 'package:dartz/dartz.dart';

class GetOrderMain implements UseCase<OrderBonusMainModel, int> {
  final Repository repository;

  GetOrderMain({required this.repository});

  @override
  Future<Either<Failure, OrderBonusMainModel>> call(int tbOrderId) async {
    try {
      final list = await repository.getOrderMain(tbOrderId: tbOrderId);
      return list;
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
