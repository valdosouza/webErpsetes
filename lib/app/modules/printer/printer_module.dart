import 'package:appweb/app/modules/home/home_module.dart';
import 'package:flutter_modular/flutter_modular.dart';

/// Monta [HomeModule] como submódulo para que [HomeBloc] e demais binds existam
/// nesta rota (só importar o módulo não registra os binds nesta árvore no Modular 5).
class PrinterModule extends Module {
  @override
  List<Bind> get binds => [];

  @override
  final List<ModularRoute> routes = [
    ModuleRoute('/', module: HomeModule()),
  ];
}
