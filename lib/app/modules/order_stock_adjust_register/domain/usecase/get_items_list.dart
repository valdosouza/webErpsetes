import 'package:appweb/app/modules/Core/data/model/order_stock_adjust_item_model.dart';
import 'package:dartz/dartz.dart';

import 'package:appweb/app/core/error/exceptions.dart';
import 'package:appweb/app/core/error/failures.dart';
import 'package:appweb/app/modules/Core/domain/usecase/usecase.dart';
import 'package:appweb/app/modules/order_stock_adjust_register/domain/repository/respository.dart';

class GetItemsList
    implements UseCase<List<OrderStockAdjustItemModel>, ParamsItemsList> {
  final Repository repository;

  GetItemsList({required this.repository});

  @override
  Future<Either<Failure, List<OrderStockAdjustItemModel>>> call(
      ParamsItemsList params) async {
    try {
      final list = await repository.getItemsList(params: params);
      return list;
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}

class ParamsItemsList {
  final int tbOrderId;
  ParamsItemsList({
    required this.tbOrderId,
  });
}
