import 'package:appweb/app/app_module.dart';
import 'package:appweb/app/modules/printer/printer_module.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_test/flutter_test.dart';

import '../test_config.dart';

void main() {
  setUpAll(configureTestEnvironment);

  test('AppModule registers /printer as PrinterModule', () {
    final app = AppModule();
    final printerRoutes = app.routes.whereType<ModuleRoute>().where(
          (r) => r.name == '/printer',
        );

    expect(printerRoutes, hasLength(1));
    expect(printerRoutes.single.context, isA<PrinterModule>());
  });
}
