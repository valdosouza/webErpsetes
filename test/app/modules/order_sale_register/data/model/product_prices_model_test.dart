import 'package:appweb/app/modules/order_sale_register/data/model/product_prices_model.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../../test_config.dart';

void main() {
  setUpAll(configureTestEnvironment);

  test('ProductPricesModel.fromJson maps product and price rows', () {
    final json = <String, dynamic>{
      'tb_institution_id': 1,
      'id': 42,
      'name_product': 'Refri 2L',
      'items': <Map<String, dynamic>>[
        <String, dynamic>{
          'id': 1,
          'name_price_list': 'Varejo',
          'price_tag': 8.5,
        },
        <String, dynamic>{
          'id': 2,
          'name_price_list': 'Atacado',
          'price_tag': 7,
        },
      ],
    };

    final model = ProductPricesModel.fromJson(json);

    expect(model.id, 42);
    expect(model.nameProduct, 'Refri 2L');
    expect(model.items.length, 2);
    expect(model.items.first.namePriceList, 'Varejo');
    expect(model.items.first.priceTag, 8.5);
    expect(model.items[1].priceTag, 7.0);
  });

  test('ProductPricesModel.empty has no items', () {
    final m = ProductPricesModel.empty();
    expect(m.items, isEmpty);
    expect(m.id, 0);
  });
}
