import 'package:appweb/app/modules/order_sale_register/data/model/order_main_model.dart';
import 'package:appweb/app/modules/order_sale_register/domain/usecase/get_order_main.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../../helpers/mocktail_order_sale_repository.dart';
import '../../../../../test_config.dart';
import '../../fixtures/order_sale_main_minimal_json.dart';

void main() {
  setUpAll(configureTestEnvironment);

  late MockOrderSaleRepository repository;
  late GetOrderMain usecase;

  setUp(() {
    repository = MockOrderSaleRepository();
    usecase = GetOrderMain(repository: repository);
  });

  test('returns OrderSaleMainModel from repository', () async {
    final model = OrderSaleMainModel.fromJson(minimalOrderSaleMainJson());
    when(
      () => repository.getOrderMain(tbOrderId: any(named: 'tbOrderId')),
    ).thenAnswer((_) async => Right(model));

    final result = await usecase(1);

    expect(result, Right(model));
    verify(() => repository.getOrderMain(tbOrderId: 1)).called(1);
  });
}
