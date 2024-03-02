import 'package:appweb/app/modules/Core/data/model/customer_list_model.dart';
import 'package:appweb/app/modules/Core/data/model/order_bonus_item_model.dart';
import 'package:appweb/app/modules/Core/data/model/product_list_model.dart';
import 'package:appweb/app/modules/Core/data/model/stock_list_model.dart';

import 'package:appweb/app/modules/order_bonus_register/data/model/order_bonus_list_model.dart';

abstract class OrderBonusRegisterState {}

class LoadingState extends OrderBonusRegisterState {}

class ErrorState extends OrderBonusRegisterState {
  final String message;
  ErrorState({
    required this.message,
  });
}

class OrderPostSuccessState extends OrderBonusRegisterState {
  final List<OrderBonusListModel> orderlist;
  OrderPostSuccessState({
    required this.orderlist,
  });
}

class OrderPutSuccessState extends OrderBonusRegisterState {}

class OrderDeleteSuccessState extends OrderBonusRegisterState {}

class OrderClosureSuccessState extends OrderBonusRegisterState {}

class OrderReopenSuccessState extends OrderBonusRegisterState {}

class OrderPostPutErrorState extends OrderBonusRegisterState {
  final String message;
  OrderPostPutErrorState({
    required this.message,
  });
}

class OrderValidateErrorState extends OrderBonusRegisterState {
  final String message;
  OrderValidateErrorState({
    required this.message,
  });
}

//======================content_order_list=======================
class OrderListLoadedState extends OrderBonusRegisterState {
  final List<OrderBonusListModel> orderList;
  OrderListLoadedState({required this.orderList});
}

//======================content_order============================
class FormOrderLoadedState extends OrderBonusRegisterState {
  final int tbOrderId;

  FormOrderLoadedState({required this.tbOrderId});
}

class OrderMainLoadedState extends OrderBonusRegisterState {}

//======================widget_customer_list============================
class CustomerListLoadedState extends OrderBonusRegisterState {
  final List<CustomerListModel> customerList;
  CustomerListLoadedState({
    required this.customerList,
  });
}

//======================widget_entity_list============================
class StockListLoadedState extends OrderBonusRegisterState {
  final List<StockListModel> stockList;
  StockListLoadedState({
    required this.stockList,
  });
}

//======================widget_items_list============================
class ItemsListLoadedSate extends OrderBonusRegisterState {
  final List<OrderBonusItemModel> itemsList;
  ItemsListLoadedSate({
    required this.itemsList,
  });
}

//======================content_items============================
class FormItemsLoadedState extends OrderBonusRegisterState {
  final int tbOrderId;

  FormItemsLoadedState({required this.tbOrderId});
}

//======================widget_product_list============================
class ProductListLoadedState extends OrderBonusRegisterState {
  final List<ProductListModel> productList;
  ProductListLoadedState({
    required this.productList,
  });
}

//======================content_item_edit============================
class GetItemToEditLoaded extends OrderBonusRegisterState {
  final OrderBonusItemModel itemEdit;
  GetItemToEditLoaded({required this.itemEdit});
}

class SetItemUpdateSuccessState extends OrderBonusRegisterState {
  final List<OrderBonusItemModel> itemsList;

  SetItemUpdateSuccessState({required this.itemsList});
}

class SetItemInsertSuccessState extends OrderBonusRegisterState {}
