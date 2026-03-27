import 'package:appweb/app/modules/order_sale_register/data/model/product_prices_model.dart';
import 'package:appweb/app/modules/order_sale_register/domain/usecase/get_product_prices.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../../helpers/mocktail_order_sale_repository.dart';
import '../../../../../test_config.dart';

void main() {
  setUpAll(() {
    configureTestEnvironment();
    registerFallbackValue(ParamsProductPrices(tbProductId: 0));
  });

  late MockOrderSaleRepository repository;
  late GetProductPrices usecase;

  setUp(() {
    repository = MockOrderSaleRepository();
    usecase = GetProductPrices(repository: repository);
  });

  test('forwards params to repository', () async {
    final model = ProductPricesModel(
      tbInstitutionId: 1,
      id: 9,
      nameProduct: 'X',
      items: [
        PricesModel(id: 1, namePriceList: 'A', priceTag: 1.0),
      ],
    );
    final params = ParamsProductPrices(tbProductId: 9);

    when(() => repository.getProductPrices(params: any(named: 'params')))
        .thenAnswer((_) async => Right(model));

    final result = await usecase(params);

    expect(result, Right(model));
    verify(() => repository.getProductPrices(params: params)).called(1);
  });
}
