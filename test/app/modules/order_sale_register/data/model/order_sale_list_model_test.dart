import 'package:appweb/app/modules/order_sale_register/data/model/order_sale_list_model.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../../test_config.dart';

void main() {
  setUpAll(configureTestEnvironment);

  test('OrderSaleListModel.fromJson maps list fields and date', () {
    final json = <String, dynamic>{
      'id': 5,
      'number': 200,
      'dt_record': '2024-02-20',
      'tb_customer_id': 1,
      'name_customer': 'ACME',
      'doc_customer': '00.000.000/0001-00',
      'tb_salesman_id': 2,
      'name_salesman': 'João',
      'doc_salesman': '111',
      'status': 'F',
    };

    final model = OrderSaleListModel.fromJson(json);

    expect(model.id, 5);
    expect(model.number, 200);
    expect(model.dtRecord, '20/02/2024');
    expect(model.nameCustomer, 'ACME');
    expect(model.nameSalesman, 'João');
    expect(model.status, 'F');
  });

  test('OrderSaleListModel.empty has zero id', () {
    final m = OrderSaleListModel.empty();
    expect(m.id, 0);
    expect(m.number, 0);
  });
}
