import 'package:appweb/app/modules/Core/data/model/order_stock_adjust_item_model.dart';
import 'package:appweb/app/modules/Core/data/model/product_list_model.dart';
import 'package:appweb/app/modules/Core/data/model/stock_list_model.dart';
import 'package:appweb/app/modules/order_stock_adjust_register/data/model/entity_list_model.dart';
import 'package:appweb/app/modules/order_stock_adjust_register/data/model/order_stock_adjust_list_model.dart';

abstract class OrderStockAdjustRegisterState {}

class LoadingState extends OrderStockAdjustRegisterState {}

class ErrorState extends OrderStockAdjustRegisterState {
  final String message;
  ErrorState({
    required this.message,
  });
}

class OrderPostSuccessState extends OrderStockAdjustRegisterState {
  final List<OrderStockAdjustListModel> orderlist;
  OrderPostSuccessState({
    required this.orderlist,
  });
}

class OrderPutSuccessState extends OrderStockAdjustRegisterState {}

class OrderDeleteSuccessState extends OrderStockAdjustRegisterState {}

class OrderClosureSuccessState extends OrderStockAdjustRegisterState {}

class OrderReopenSuccessState extends OrderStockAdjustRegisterState {}

class OrderPostPutErrorState extends OrderStockAdjustRegisterState {
  final String message;
  OrderPostPutErrorState({
    required this.message,
  });
}

class OrderValidateErrorState extends OrderStockAdjustRegisterState {
  final String message;
  OrderValidateErrorState({
    required this.message,
  });
}

//======================content_order_list=======================
class OrderListLoadedState extends OrderStockAdjustRegisterState {
  final List<OrderStockAdjustListModel> orderList;
  OrderListLoadedState({required this.orderList});
}

//======================content_order============================
class FormOrderLoadedState extends OrderStockAdjustRegisterState {
  final int tbOrderId;

  FormOrderLoadedState({required this.tbOrderId});
}

class OrderMainLoadedState extends OrderStockAdjustRegisterState {}

//======================widget_entity_list============================
class EntityListLoadedState extends OrderStockAdjustRegisterState {
  final List<EntityListModel> entityList;
  EntityListLoadedState({
    required this.entityList,
  });
}

//======================widget_entity_list============================
class StockListLoadedState extends OrderStockAdjustRegisterState {
  final List<StockListModel> stockList;
  StockListLoadedState({
    required this.stockList,
  });
}

//======================widget_items_list============================
class ItemsListLoadedSate extends OrderStockAdjustRegisterState {
  final List<OrderStockAdjustItemModel> itemsList;
  ItemsListLoadedSate({
    required this.itemsList,
  });
}

//======================content_items============================
class FormItemsLoadedState extends OrderStockAdjustRegisterState {
  final int tbOrderId;

  FormItemsLoadedState({required this.tbOrderId});
}

//======================widget_product_list============================
class ProductListLoadedState extends OrderStockAdjustRegisterState {
  final List<ProductListModel> productList;
  ProductListLoadedState({
    required this.productList,
  });
}

//======================content_item_edit============================
class GetItemToEditLoaded extends OrderStockAdjustRegisterState {
  final OrderStockAdjustItemModel itemEdit;
  GetItemToEditLoaded({required this.itemEdit});
}

class SetItemUpdateSuccessState extends OrderStockAdjustRegisterState {}
