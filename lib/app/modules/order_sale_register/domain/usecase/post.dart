import 'package:appweb/app/core/error/exceptions.dart';
import 'package:appweb/app/core/error/failures.dart';
import 'package:appweb/app/modules/Core/domain/usecase/usecase.dart';
import 'package:appweb/app/modules/order_sale_register/data/model/order_main_model.dart';
import 'package:appweb/app/modules/order_sale_register/data/model/order_sale_list_model.dart';
import 'package:appweb/app/modules/order_sale_register/domain/repository/respository.dart';
import 'package:dartz/dartz.dart';

class Post implements UseCase<OrderSaleListModel, OrderSaleMainModel> {
  final Repository repository;

  Post({required this.repository});

  @override
  Future<Either<Failure, OrderSaleListModel>> call(
      OrderSaleMainModel params) async {
    try {
      final response = await repository.post(params: params);
      return response;
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
