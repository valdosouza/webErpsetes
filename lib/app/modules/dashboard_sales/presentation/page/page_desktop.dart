//import 'package:appweb/app/core/shared/widgets/custom_circular_progress_indicator.dart';
import 'package:appweb/app/modules/dashboard_sales/presentation/content/content_desktop.dart';
import 'package:appweb/app/modules/stock_balance/presentation/bloc/bloc.dart';
import 'package:appweb/app/modules/stock_balance/presentation/bloc/state.dart';
import 'package:appweb/app/modules/stock_balance/stock_balance_module.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

class PageDesktop extends StatefulWidget {
  const PageDesktop({super.key});

  @override
  State<PageDesktop> createState() => PageDesktopState();
}

class PageDesktopState extends State<PageDesktop> {
  late final StockBalanceBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = Modular.get<StockBalanceBloc>();
    Future.delayed(const Duration(milliseconds: 100)).then((_) async {
      await Modular.isModuleReady<StockBalanceModule>();
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<StockBalanceBloc, StockBalanceState>(
      bloc: bloc,
      listener: (context, state) {},
      builder: (context, state) {
        /*
        if (state is LoadingState) {
          return const Center(
            child: CustomCircularProgressIndicator(),
          );
        }
        */
        return const ContentDesktop();
      },
    );
  }
}
