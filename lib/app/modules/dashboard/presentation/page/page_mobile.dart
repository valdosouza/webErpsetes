import 'package:appweb/app/core/shared/widgets/custom_circular_progress_indicator.dart';
import 'package:appweb/app/modules/stock_balance/domain/usecase/get_stock_balance_list.dart';
import 'package:appweb/app/modules/stock_balance/presentation/bloc/bloc.dart';
import 'package:appweb/app/modules/stock_balance/presentation/bloc/event.dart';
import 'package:appweb/app/modules/stock_balance/presentation/bloc/state.dart';
import 'package:appweb/app/modules/stock_balance/presentation/widget/widget_stock_balance_list.dart';
import 'package:appweb/app/modules/stock_balance/stock_balance_module.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

class PageMobile extends StatefulWidget {
  const PageMobile({super.key});

  @override
  State<PageMobile> createState() => PageMobileState();
}

class PageMobileState extends State<PageMobile> {
  late final StockBalanceBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = Modular.get<StockBalanceBloc>();
    Future.delayed(const Duration(milliseconds: 100)).then((_) async {
      await Modular.isModuleReady<StockBalanceModule>();
    });
    if (bloc.stockList.isEmpty) {
      bloc.add(
        GetStockBalanceListEvent(
          params: ParamsStockBalanceList(
            tbInstitutionId: 0,
            page: 0,
            id: 0,
            tbSalesmanId: 0,
            tbStockListId: 3,
            nameMerchandise: "",
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<StockBalanceBloc, StockBalanceState>(
      bloc: bloc,
      listener: (context, state) {},
      builder: (context, state) {
        if (state is LoadingState) {
          return const Center(
            child: CustomCircularProgressIndicator(),
          );
        }
        if (state is StockBalanceListLoadedState) {
          return WidgetStockBalanceList(
              stockBalanceList: state.stockBalanceList);
        }
        return Container();
      },
    );
  }
}
