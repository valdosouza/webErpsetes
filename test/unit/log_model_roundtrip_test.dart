import 'package:appweb/app/modules/log/data/model/log_model.dart';
import 'package:flutter_test/flutter_test.dart';

import '../test_config.dart';

void main() {
  setUpAll(configureTestEnvironment);

  test('LogModel fromJson/toJson roundtrip preserves keys', () {
    final json = <String, dynamic>{
      'tm_record': '2024-01-01 10:00:00',
      'interface_name': 'Sales',
      'operation': 'INSERT',
      'reference': 'ref-1',
      'note': 'ok',
    };

    final model = LogModel.fromJson(json);
    final out = model.toJson();

    expect(out, equals(json));
  });

  test('LogModel.empty has blank fields', () {
    final empty = LogModel.empty();
    expect(empty.interfaceName, '');
    expect(empty.operation, '');
  });
}
