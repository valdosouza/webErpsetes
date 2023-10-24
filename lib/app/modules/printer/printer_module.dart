import 'package:appweb/app/modules/printer/presentation/page/printer_page.dart';
import 'package:flutter_modular/flutter_modular.dart';

class PrinterModule extends Module {
  @override
  List<Bind> get binds => [];
  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      '/',
      child: (_, args) => const PrinterPage(),
    ),
  ];
}
