import 'package:appweb/app/modules/Core/data/model/order_stock_transfer_item_model.dart';
import 'package:appweb/app/modules/Core/data/model/product_list_model.dart';
import 'package:appweb/app/modules/order_stock_transfer_register/data/model/entity_list_model.dart';
import 'package:appweb/app/modules/order_stock_transfer_register/data/model/order_stock_transfer_list_model.dart';

abstract class OrderStockTransferRegisterState {}

class LoadingState extends OrderStockTransferRegisterState {}

class ErrorState extends OrderStockTransferRegisterState {
  final String message;
  ErrorState({
    required this.message,
  });
}

class OrderPostSuccessState extends OrderStockTransferRegisterState {
  final List<OrderStockTransferListModel> orderlist;
  OrderPostSuccessState({
    required this.orderlist,
  });
}

class OrderPutSuccessState extends OrderStockTransferRegisterState {}

class OrderDeleteSuccessState extends OrderStockTransferRegisterState {}

class OrderClosureSuccessState extends OrderStockTransferRegisterState {}

class OrderReopenSuccessState extends OrderStockTransferRegisterState {}

class OrderPostPutErrorState extends OrderStockTransferRegisterState {
  final String message;
  OrderPostPutErrorState({
    required this.message,
  });
}

//======================content_order_list=======================
class OrderListLoadedState extends OrderStockTransferRegisterState {
  final List<OrderStockTransferListModel> orderList;
  OrderListLoadedState({required this.orderList});
}

//======================content_order============================
class FormOrderLoadedState extends OrderStockTransferRegisterState {
  final int tbOrderId;

  FormOrderLoadedState({required this.tbOrderId});
}

class OrderMainLoadedState extends OrderStockTransferRegisterState {}

//======================widget_entity_list============================
class EntityListLoadedState extends OrderStockTransferRegisterState {
  final List<EntityListModel> entityList;
  EntityListLoadedState({
    required this.entityList,
  });
}

//======================widget_items_list============================
class ItemsListLoadedSate extends OrderStockTransferRegisterState {
  final List<OrderStockTransferItemModel> itemsList;
  ItemsListLoadedSate({
    required this.itemsList,
  });
}

//======================content_items============================
class FormItemsLoadedState extends OrderStockTransferRegisterState {
  final int tbOrderId;

  FormItemsLoadedState({required this.tbOrderId});
}

//======================widget_product_list============================
class ProductListLoadedState extends OrderStockTransferRegisterState {
  final List<ProductListModel> productList;
  ProductListLoadedState({
    required this.productList,
  });
}

//======================content_item_edit============================
class GetItemToEditLoaded extends OrderStockTransferRegisterState {
  final OrderStockTransferItemModel itemEdit;
  GetItemToEditLoaded({required this.itemEdit});
}

class SetItemUpdateSuccessState extends OrderStockTransferRegisterState {}
