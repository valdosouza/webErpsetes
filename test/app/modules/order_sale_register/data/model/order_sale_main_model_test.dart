import 'package:appweb/app/modules/order_sale_register/data/model/order_main_model.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../fixtures/order_sale_main_minimal_json.dart';
import '../../../../../test_config.dart';

void main() {
  setUpAll(configureTestEnvironment);

  test('OrderSaleMainModel.fromJson maps sale and order ids', () {
    final json = minimalOrderSaleMainJson();
    final model = OrderSaleMainModel.fromJson(json);

    expect(model.order.id, 1);
    expect(model.orderSale.number, 99);
    expect(model.orderSale.nameCustomer, 'Cliente X');
    expect(model.orderBilling.namePayment, 'Dinheiro');
    expect(model.items.length, 1);
    expect(model.items.first.nameProduct, 'Produto A');
    expect(model.items.first.quantity, 2.0);
  });

  test('OrderSaleMainModel.toJson includes nested keys', () {
    final model = OrderSaleMainModel.fromJson(minimalOrderSaleMainJson());
    final out = model.toJson();

    expect(out['order'], isA<Map<String, dynamic>>());
    expect(out['sale'], isA<Map<String, dynamic>>());
    expect(out['items'], isA<List<dynamic>>());
    expect((out['items'] as List).length, 1);
  });

  test('OrderSaleMainModel.empty has no items', () {
    final empty = OrderSaleMainModel.empty();
    expect(empty.items, isEmpty);
    expect(empty.order.id, 0);
  });
}
