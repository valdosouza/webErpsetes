import 'package:appweb/app/core/error/exceptions.dart';
import 'package:appweb/app/core/error/failures.dart';
import 'package:appweb/app/modules/Core/domain/usecase/usecase.dart';
import 'package:appweb/app/modules/order_stock_adjust_register/data/model/order_main_model.dart';
import 'package:appweb/app/modules/order_stock_adjust_register/data/model/order_stock_adjust_list_model.dart';
import 'package:appweb/app/modules/order_stock_adjust_register/domain/repository/respository.dart';
import 'package:dartz/dartz.dart';

class Post
    implements UseCase<OrderStockAdjustListModel, OrderStockAdjustMainModel> {
  final Repository repository;

  Post({required this.repository});

  @override
  Future<Either<Failure, OrderStockAdjustListModel>> call(
      OrderStockAdjustMainModel params) async {
    try {
      final response = await repository.post(params: params);
      return response;
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
