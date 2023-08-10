import 'package:appweb/app/modules/order_sale_register/data/model/product_prices_model.dart';
import 'package:dartz/dartz.dart';
import 'package:appweb/app/core/error/exceptions.dart';
import 'package:appweb/app/core/error/failures.dart';
import 'package:appweb/app/modules/Core/domain/usecase/usecase.dart';
import 'package:appweb/app/modules/order_sale_register/domain/repository/respository.dart';

class GetProductPrices
    implements UseCase<ProductPricesModel, ParamsProductPrices> {
  final Repository repository;

  GetProductPrices({required this.repository});

  @override
  Future<Either<Failure, ProductPricesModel>> call(
      ParamsProductPrices params) async {
    try {
      final productPrice = await repository.getProductPrices(params: params);
      return productPrice;
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}

class ParamsProductPrices {
  int tbProductId;
  ParamsProductPrices({
    required this.tbProductId,
  });
}
