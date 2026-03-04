import 'package:appweb/app/modules/log/data/datassource/datasource.dart';
import 'package:appweb/app/modules/log/data/repository/repository_impl.dart';
import 'package:appweb/app/modules/log/domain/usecase/delete_log.dart';
import 'package:appweb/app/modules/log/domain/usecase/get_log.dart';
import 'package:appweb/app/modules/log/domain/usecase/send_log.dart';
import 'package:appweb/app/modules/log/domain/usecase/set_log.dart';
import 'package:appweb/app/modules/log/presentation/bloc/bloc.dart';
import 'package:appweb/app/modules/log/presentation/page/page.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:modular_bloc_bind/modular_bloc_bind.dart';

class LogModule extends Module {
  @override
  List<Bind> get binds => [
        Bind.factory(
          (i) => DatasourceImpl(),
        ),
        Bind.factory(
          (i) => RepositoryImpl(datasource: i.get<DatasourceImpl>()),
        ),
        Bind.factory(
          (i) => SetLog(repository: i.get<RepositoryImpl>()),
        ),
        Bind.factory(
          (i) => GetLog(repository: i.get<RepositoryImpl>()),
        ),
        Bind.factory(
          (i) => DeleteLog(repository: i.get<RepositoryImpl>()),
        ),
        Bind.factory(
          (i) => SendLog(repository: i.get<RepositoryImpl>()),
        ),
        BlocBind.singleton((i) => LogBloc(
              getLog: i.get<GetLog>(),
              setLog: i.get<SetLog>(),
              deleteLog: i.get<DeleteLog>(),
              sendLog: i.get<SendLog>(),
            ))
      ];
  @override
  final List<ModularRoute> routes = [
    ChildRoute('/', child: (_, args) => const Page()),
  ];
}
