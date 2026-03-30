import 'package:appweb/app/modules/printer/printer_module.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../test_config.dart';

void main() {
  setUpAll(configureTestEnvironment);

  group('PrinterModule', () {
    test('does not declare extra binds', () {
      final module = PrinterModule();
      expect(module.binds, isEmpty);
    });

    test('mounts PrinterPage at / as a single ChildRoute', () {
      final module = PrinterModule();
      expect(module.routes, hasLength(1));

      final route = module.routes.single;
      expect(route, isA<ChildRoute>());
      expect(route.name, '/');
    });
  });
}
