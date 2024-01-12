import 'package:appweb/app/modules/Core/core_module.dart';
import 'package:appweb/app/modules/Core/domain/usecase/get_cep.dart';
import 'package:appweb/app/modules/Core/domain/usecase/get_citys.dart';
import 'package:appweb/app/modules/Core/domain/usecase/get_cnpj.dart';
import 'package:appweb/app/modules/Core/domain/usecase/get_states.dart';
import 'package:appweb/app/modules/customer_register/data/datasource/datasource.dart';
import 'package:appweb/app/modules/customer_register/data/repository/repository_impl.dart';
import 'package:appweb/app/modules/customer_register/domain/usecase/get.dart';
import 'package:appweb/app/modules/customer_register/domain/usecase/get_list.dart';
import 'package:appweb/app/modules/customer_register/domain/usecase/post.dart';
import 'package:appweb/app/modules/customer_register/presentation/bloc/bloc.dart';
import 'package:appweb/app/modules/customer_register/presentation/page/customer_register_page.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:modular_bloc_bind/modular_bloc_bind.dart';
import 'package:http/http.dart' as http;

class CustomerRegisterModule extends Module {
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
          (i) => GetList(repository: i.get<RepositoryImpl>()),
        ),
        Bind.factory(
          (i) => Get(repository: i.get<RepositoryImpl>()),
        ),
        Bind.factory(
          (i) => Post(repository: i.get<RepositoryImpl>()),
        ),
        Bind.factory<DataSource>(
          (i) => DataSourceImpl(httpClient: http.Client()),
        ),
        BlocBind.singleton((i) => CustomerRegisterBloc(
              getList: i.get<GetList>(),
              getCep: i.get<GetCep>(),
              getCity: i.get<GetCities>(),
              getCnpj: i.get<GetCnpj>(),
              getStates: i.get<GetStates>(),
              get: i.get<Get>(),
              post: i.get<Post>(),
            )),
      ];
  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      '/',
      child: (_, args) => CustomerRegisterPage(
          tbCustomerId: args.data[0], routeCallBack: args.data[1]),
    ),
  ];
}
