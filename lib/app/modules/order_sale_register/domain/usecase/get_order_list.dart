import 'package:appweb/app/core/error/exceptions.dart';
import 'package:appweb/app/core/error/failures.dart';
import 'package:appweb/app/modules/Core/domain/usecase/usecase.dart';
import 'package:appweb/app/modules/order_sale_register/data/model/order_sale_list_model.dart';
import 'package:appweb/app/modules/order_sale_register/domain/repository/respository.dart';
import 'package:dartz/dartz.dart';

class GetOrderList implements UseCase<List<OrderSaleListModel>, String> {
  final Repository repository;

  GetOrderList({required this.repository});

  @override
  Future<Either<Failure, List<OrderSaleListModel>>> call(String params) async {
    try {
      final list = await repository.getOrderList();
      return list;
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}

class ParamsGetListStock {}
