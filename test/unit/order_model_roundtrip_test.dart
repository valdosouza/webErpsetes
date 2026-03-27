import 'package:appweb/app/modules/Core/data/model/order_model.dart';
import 'package:flutter_test/flutter_test.dart';

import '../test_config.dart';

void main() {
  setUpAll(configureTestEnvironment);

  test('OrderModel fromJson/toJson roundtrip keeps core fields', () {
    final json = <String, dynamic>{
      'id': 10,
      'tb_institution_id': 2,
      'terminal': 1,
      'tb_user_id': 5,
      'doc_user': 'DOC1',
      'dt_record': '2023-06-15',
      'note': 'n',
      'origin': 'web',
      'status': 'A',
      'being_used': 'N',
    };

    final model = OrderModel.fromJson(json);
    final out = model.toJson();

    expect(out['id'], 10);
    expect(out['tb_institution_id'], 2);
    expect(out['dt_record'], '2023-06-15');
    expect(out['doc_user'], 'DOC1');
    expect(out['status'], 'A');
  });

  test('OrderModel.empty exposes stable defaults', () {
    final empty = OrderModel.empty();
    expect(empty.id, 0);
    expect(empty.status, 'A');
  });
}
