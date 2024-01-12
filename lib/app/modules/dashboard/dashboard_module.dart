import 'package:appweb/app/modules/dashboard/presentation/page/page.dart';
import 'package:appweb/app/modules/dashboard_sales/dashboard_sales_module.dart';
import 'package:flutter_modular/flutter_modular.dart';

class DashboardModule extends Module {
  @override
  List<Bind> get binds => [];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(
          '/',
          child: (_, args) => const Page(),
          children: [
            ModuleRoute(
              '/sales/',
              module: DashboardSaleModule(),
            ),
          ],
        ),
      ];
}
