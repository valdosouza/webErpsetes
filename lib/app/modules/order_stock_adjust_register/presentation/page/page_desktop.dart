import 'package:appweb/app/core/shared/utils/toast.dart';
import 'package:appweb/app/core/shared/widgets/custom_circular_progress_indicator.dart';
import 'package:appweb/app/modules/order_stock_adjust_register/presentation/content/content_order_main.dart';
import 'package:appweb/app/modules/order_stock_adjust_register/domain/usecase/get_order_list.dart';
import 'package:appweb/app/modules/order_stock_adjust_register/order_stock_adjust_register_module.dart';
import 'package:appweb/app/modules/order_stock_adjust_register/presentation/bloc/bloc.dart';
import 'package:appweb/app/modules/order_stock_adjust_register/presentation/bloc/event.dart';
import 'package:appweb/app/modules/order_stock_adjust_register/presentation/bloc/state.dart';
import 'package:appweb/app/modules/order_stock_adjust_register/presentation/content/content_item_edit.dart';
import 'package:appweb/app/modules/order_stock_adjust_register/presentation/content/content_items_list.dart';
import 'package:appweb/app/modules/order_stock_adjust_register/presentation/content/content_order_list.dart';
import 'package:appweb/app/modules/order_stock_adjust_register/presentation/widget/widget_entity_list.dart';
import 'package:appweb/app/modules/order_stock_adjust_register/presentation/widget/widget_product_list.dart';
import 'package:appweb/app/modules/order_stock_adjust_register/presentation/widget/widget_stock_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

class PageDesktop extends StatefulWidget {
  const PageDesktop({super.key});

  @override
  State<PageDesktop> createState() => PageDesktopState();
}

class PageDesktopState extends State<PageDesktop> {
  late final OrderStockAdjustRegisterBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = Modular.get<OrderStockAdjustRegisterBloc>();
    Future.delayed(const Duration(milliseconds: 100)).then((_) async {
      await Modular.isModuleReady<OrderStockAdjustRegisterModule>();
    });
    if (bloc.orderList.isEmpty) {
      bloc.add(GetOrderListEvent(
          params: ParamsOrderList(
        tbInstitutionId: 0,
        page: 0,
        tbUserId: 0,
        nickTrade: "",
        number: 0,
      )));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OrderStockAdjustRegisterBloc,
        OrderStockAdjustRegisterState>(
      bloc: bloc,
      listener: (context, state) {
        if (state is OrderValidateErrorState) {
          CustomToast.showToast(state.message);
        }
      },
      builder: (context, state) {
        if (state is LoadingState) {
          return const Center(
            child: CustomCircularProgressIndicator(),
          );
        }
        if (state is OrderListLoadedState) {
          return ContentOrderList(orderlist: state.orderList);
        }
        if (state is FormOrderLoadedState) {
          return const ContentOrderMain();
        }
        if (state is EntityListLoadedState) {
          return WidgetEntityList(entityList: state.entityList);
        }
        if (state is ItemsListLoadedSate) {
          return ContentItemsList(itemslist: state.itemsList);
        }
        if (state is ProductListLoadedState) {
          return WidgetProductList(
            productList: state.productList,
          );
        }
        if (state is StockListLoadedState) {
          return WidgetStockList(stockList: state.stockList);
        }

        if (state is SetItemUpdateSuccessState) {
          return WidgetProductList(
            productList: bloc.productList,
          );
        }
        if (state is GetItemToEditLoaded) {
          return ContentItemEdit(itemEdit: state.itemEdit);
        }
        if ((state is OrderPostSuccessState) ||
            (state is OrderPutSuccessState) ||
            (state is OrderDeleteSuccessState) ||
            (state is OrderClosureSuccessState) ||
            (state is OrderReopenSuccessState)) {
          return ContentOrderList(orderlist: bloc.orderList);
        }
        if (state is OrderMainLoadedState) {
          return const ContentOrderMain();
        }
        if (state is OrderValidateErrorState) {
          return const ContentOrderMain();
        }

        return Container();
      },
    );
  }
}
