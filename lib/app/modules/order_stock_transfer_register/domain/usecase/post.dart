import 'package:appweb/app/core/error/exceptions.dart';
import 'package:appweb/app/core/error/failures.dart';
import 'package:appweb/app/modules/Core/domain/usecase/usecase.dart';
import 'package:appweb/app/modules/order_stock_transfer_register/data/model/order_main_model.dart';
import 'package:appweb/app/modules/order_stock_transfer_register/data/model/order_stock_transfer_list_model.dart';
import 'package:appweb/app/modules/order_stock_transfer_register/domain/repository/respository.dart';
import 'package:dartz/dartz.dart';

class Post
    implements
        UseCase<OrderStockTransferListModel, OrderStockTransferMainModel> {
  final Repository repository;

  Post({required this.repository});

  @override
  Future<Either<Failure, OrderStockTransferListModel>> call(
      OrderStockTransferMainModel params) async {
    try {
      final response = await repository.post(params: params);
      return response;
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
