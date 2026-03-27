import 'package:appweb/app/modules/order_sale_register/data/model/payment_types_list_model.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../../test_config.dart';

void main() {
  setUpAll(configureTestEnvironment);

  test('PaymentTypesListModel.fromJson maps fields', () {
    final json = <String, dynamic>{
      'id': 3,
      'tb_institution_id': 1,
      'description': 'Cartão crédito',
      'active': 'S',
    };

    final m = PaymentTypesListModel.fromJson(json);

    expect(m.id, 3);
    expect(m.tbIinstitutionId, 1);
    expect(m.description, 'Cartão crédito');
    expect(m.active, 'S');
  });
}
