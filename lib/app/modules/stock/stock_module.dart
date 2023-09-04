import 'package:appweb/app/modules/order_stock_adjust_register/order_stock_adjust_register_module.dart';
import 'package:appweb/app/modules/order_stock_transfer_register/order_stock_transfer_register_module.dart';
import 'package:appweb/app/modules/order_stock_transfer_register/presentation/page/page.dart';
import 'package:appweb/app/modules/stock/presentation/page/stock_page_desktop.dart';
import 'package:appweb/app/modules/stock/presentation/page/stock_page_mobile.dart';
import 'package:appweb/app/modules/stock_balance/presentation/page/page_stock_balance.dart';
import 'package:appweb/app/modules/stock_balance/stock_balance_module.dart';
import 'package:flutter_modular/flutter_modular.dart';

class StockModule extends Module {
  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      '/desktop/',
      child: (_, args) => const StockPageDesktop(),
      children: [
        ModuleRoute(
          '/stockadjustement/',
          module: OrderStockAdjustRegisterModule(),
        ),
        ModuleRoute(
          '/stocktransfer/',
          module: OrderStockTransferRegisterModule(),
        ),
        ModuleRoute(
          '/stockbalance/',
          module: StockBalanceModule(),
        ),
      ],
    ),
    ChildRoute(
      '/mobile/',
      child: (_, args) => const StockPageMobile(),
    ),
    ChildRoute(
      '/mobile/reload/',
      child: (_, args) => const Page(),
      children: [
        ModuleRoute(
          '/stocktransfer/',
          module: OrderStockTransferRegisterModule(),
        ),
      ],
    ),
    ChildRoute(
      '/mobile/balance/',
      child: (_, args) => const PageStockBalance(),
      children: [
        ModuleRoute(
          '/stockbalance/',
          module: StockBalanceModule(),
        ),
      ],
    ),
  ];
}
