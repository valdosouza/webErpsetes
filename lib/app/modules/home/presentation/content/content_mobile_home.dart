import 'package:appweb/app/modules/home/presentation/bloc/home_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

class ContentMobileHome extends StatefulWidget {
  const ContentMobileHome({super.key});

  @override
  State<ContentMobileHome> createState() => _ContentMobileHomeState();
}

class _ContentMobileHomeState extends State<ContentMobileHome> {
  late final HomeBloc bloc;
  late DateTime initialDate = DateTime.now();
  late DateTime finalDate = DateTime.now();
  String selectedTerminal = 'Todos';

  @override
  void initState() {
    super.initState();
    bloc = Modular.get<HomeBloc>();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => bloc,
      child: Container(),
    );
  }
}
