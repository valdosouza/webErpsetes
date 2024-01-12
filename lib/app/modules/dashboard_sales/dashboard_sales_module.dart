import 'package:appweb/app/modules/dashboard_sales/presentation/page/page.dart';
import 'package:appweb/app/modules/stock_balance/data/datasource/datasource.dart';
import 'package:appweb/app/modules/stock_balance/data/repository/repository_impl.dart';
import 'package:appweb/app/modules/stock_balance/domain/repository/repository.dart';
import 'package:appweb/app/modules/stock_balance/domain/usecase/get_stock_balance_list.dart';
import 'package:appweb/app/modules/stock_balance/domain/usecase/get_stock_list.dart';
import 'package:appweb/app/modules/stock_balance/presentation/bloc/bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:http/http.dart' as http;

class DashboardSaleModule extends Module {
  @override
  List<Bind> get binds => [
        Bind.factory(
          (i) => DataSourceImpl(httpClient: http.Client()),
        ),
        Bind.factory(
          (i) => RepositoryImpl(datasource: i.get<DataSource>()),
        ),
        Bind.factory(
          (i) => GetStockList(repository: i.get<Repository>()),
        ),
        Bind.factory(
          (i) => GetStockBalanceList(repository: i.get<Repository>()),
        ),
        Bind.singleton(
          (i) => StockBalanceBloc(
            getStockList: i.get<GetStockList>(),
            getStockBalanceList: i.get<GetStockBalanceList>(),
          ),
        ),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute('/', child: (_, args) => const Page()),
      ];
}
