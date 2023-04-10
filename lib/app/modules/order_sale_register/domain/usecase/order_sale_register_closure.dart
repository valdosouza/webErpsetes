import 'package:appweb/app/core/error/exceptions.dart';
import 'package:appweb/app/core/error/failures.dart';
import 'package:appweb/app/modules/Core/domain/usecase/usecase.dart';
import 'package:appweb/app/modules/Core/data/model/order_status_model.dart';
import 'package:appweb/app/modules/order_sale_register/domain/repository/order_sale_register_respository.dart';
import 'package:dartz/dartz.dart';

class OrderSaleRegisterClosure
    implements UseCase<String, ParamsOrderSaleClosure> {
  final OrderSaleRegisterRepository repository;

  OrderSaleRegisterClosure({required this.repository});

  @override
  Future<Either<Failure, String>> call(ParamsOrderSaleClosure params) async {
    try {
      final response = await repository.closure(model: params.model);
      return response;
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}

class ParamsOrderSaleClosure {
  OrderStatusModel model;
  ParamsOrderSaleClosure({required this.model});
}
