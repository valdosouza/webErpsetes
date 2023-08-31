import 'package:appweb/app/modules/Core/core_module.dart';
import 'package:appweb/app/modules/order_stock_adjust_register/data/datasource/datasource.dart';
import 'package:appweb/app/modules/order_stock_adjust_register/data/repository/repository_impl.dart';
import 'package:appweb/app/modules/order_stock_adjust_register/domain/usecase/closure.dart';
import 'package:appweb/app/modules/order_stock_adjust_register/domain/usecase/delete.dart';
import 'package:appweb/app/modules/order_stock_adjust_register/domain/usecase/get_entity_list.dart';
import 'package:appweb/app/modules/order_stock_adjust_register/domain/usecase/get_items_list.dart';
import 'package:appweb/app/modules/order_stock_adjust_register/domain/usecase/get_order_list.dart';
import 'package:appweb/app/modules/order_stock_adjust_register/domain/usecase/get_order_main.dart';
import 'package:appweb/app/modules/order_stock_adjust_register/domain/usecase/get_product_list.dart';
import 'package:appweb/app/modules/order_stock_adjust_register/domain/usecase/get_stock_list.dart';
import 'package:appweb/app/modules/order_stock_adjust_register/domain/usecase/post.dart';
import 'package:appweb/app/modules/order_stock_adjust_register/domain/usecase/put.dart';
import 'package:appweb/app/modules/order_stock_adjust_register/domain/usecase/reopen.dart';
import 'package:appweb/app/modules/order_stock_adjust_register/presentation/bloc/bloc.dart';
import 'package:appweb/app/modules/order_stock_adjust_register/presentation/page/page.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:http/http.dart' as http;

class OrderStockAdjustRegisterModule extends Module {
  @override
  List<Module> get imports => [
        CoreModule(),
      ];
  @override
  List<Bind> get binds => [
        Bind.factory<DataSource>(
          (i) => DataSourceImpl(httpClient: http.Client()),
        ),
        Bind.factory(
          (i) => RepositoryImpl(datasource: i.get<DataSource>()),
        ),
        Bind.factory(
          (i) => GetOrderList(repository: i.get<RepositoryImpl>()),
        ),
        Bind.factory(
          (i) => GetOrderMain(repository: i.get<RepositoryImpl>()),
        ),
        Bind.factory(
          (i) => GetEntityList(repository: i.get<RepositoryImpl>()),
        ),
        Bind.factory(
          (i) => GetItemsList(repository: i.get<RepositoryImpl>()),
        ),
        Bind.factory(
          (i) => GetStockList(repository: i.get<RepositoryImpl>()),
        ),
        Bind.factory(
          (i) => GetProductList(repository: i.get<RepositoryImpl>()),
        ),
        Bind.factory(
          (i) => Post(repository: i.get<RepositoryImpl>()),
        ),
        Bind.factory(
          (i) => Put(repository: i.get<RepositoryImpl>()),
        ),
        Bind.factory(
          (i) => Delete(repository: i.get<RepositoryImpl>()),
        ),
        Bind.factory(
          (i) => Closure(repository: i.get<RepositoryImpl>()),
        ),
        Bind.factory(
          (i) => Reopen(repository: i.get<RepositoryImpl>()),
        ),
        Bind.singleton(
          (i) => OrderStockAdjustRegisterBloc(
            getOrderList: i.get<GetOrderList>(),
            getOrderMain: i.get<GetOrderMain>(),
            getEntityList: i.get<GetEntityList>(),
            getItemsList: i.get<GetItemsList>(),
            getProductList: i.get<GetProductList>(),
            post: i.get<Post>(),
            put: i.get<Put>(),
            delete: i.get<Delete>(),
            closure: i.get<Closure>(),
            reopen: i.get<Reopen>(),
            getStockList: i.get<GetStockList>(),
          ),
        ),
      ];
  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      '/',
      child: (_, args) => const Page(),
    ),
  ];
}
