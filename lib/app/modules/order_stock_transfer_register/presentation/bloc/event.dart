import 'package:appweb/app/modules/Core/data/model/order_stock_transfer_item_model.dart';
import 'package:appweb/app/modules/order_stock_transfer_register/domain/usecase/closure.dart';
import 'package:appweb/app/modules/order_stock_transfer_register/domain/usecase/delete.dart';
import 'package:appweb/app/modules/order_stock_transfer_register/domain/usecase/get_entity_list.dart';
import 'package:appweb/app/modules/order_stock_transfer_register/domain/usecase/get_items_list.dart';
import 'package:appweb/app/modules/order_stock_transfer_register/domain/usecase/get_order_list.dart';
import 'package:appweb/app/modules/order_stock_transfer_register/domain/usecase/get_product_list.dart';
import 'package:appweb/app/modules/order_stock_transfer_register/domain/usecase/reopen.dart';

abstract class OrderStockTransferRegisterEvent {}

//======================content_order_sale============================
class GetOrderListEvent extends OrderStockTransferRegisterEvent {
  ParamsOrderList params;
  GetOrderListEvent({required this.params});
}

class SearchOrderEvent extends OrderStockTransferRegisterEvent {
  final ParamsOrderList params;

  SearchOrderEvent({required this.params});
}

class FilterOrderEvent extends OrderStockTransferRegisterEvent {}

class NewFormOrderEvent extends OrderStockTransferRegisterEvent {}

class FormOrderEvent extends OrderStockTransferRegisterEvent {
  final int tbOrderId;
  FormOrderEvent({
    required this.tbOrderId,
  });
}

class GetOrderMainEvent extends OrderStockTransferRegisterEvent {
  final int tbOrderId;
  GetOrderMainEvent({
    required this.tbOrderId,
  });
}

class ReturnToOrderMainEvent extends OrderStockTransferRegisterEvent {}

class PostOrderEvent extends OrderStockTransferRegisterEvent {}

class PutOrderEvent extends OrderStockTransferRegisterEvent {}

class DeleteOrderEvent extends OrderStockTransferRegisterEvent {
  final ParamsDeleteOrder params;
  DeleteOrderEvent({
    required this.params,
  });
}

class ClosureOrderEvent extends OrderStockTransferRegisterEvent {
  final ParamsClosureOrder params;
  ClosureOrderEvent({
    required this.params,
  });
}

class ReopenOrderEvent extends OrderStockTransferRegisterEvent {
  final ParamsReopenOrder params;
  ReopenOrderEvent({
    required this.params,
  });
}

//======================widget_entity_list============================
class GetEntityListEvent extends OrderStockTransferRegisterEvent {
  final ParamsEntityList params;
  GetEntityListEvent({required this.params});
}

class SearchEntityEvent extends OrderStockTransferRegisterEvent {
  final ParamsEntityList params;

  SearchEntityEvent({required this.params});
}

class FilterEntityEvent extends OrderStockTransferRegisterEvent {}

class FilterPaymentTypeEvent extends OrderStockTransferRegisterEvent {}
//======================content_items============================

class GetItemsListEvent extends OrderStockTransferRegisterEvent {
  final ParamsItemsList params;
  GetItemsListEvent({
    required this.params,
  });
}

class FormItemsEvent extends OrderStockTransferRegisterEvent {
  final int tbOrderId;
  FormItemsEvent({
    required this.tbOrderId,
  });
}

//======================widget_product_list============================

class GetProductListEvent extends OrderStockTransferRegisterEvent {
  final ParamsProductList params;
  GetProductListEvent({
    required this.params,
  });
}

class GetFormProductListEvent extends OrderStockTransferRegisterEvent {}

class SearchProductEvent extends OrderStockTransferRegisterEvent {
  final ParamsProductList params;

  SearchProductEvent({required this.params});
}

class FilterProductEvent extends OrderStockTransferRegisterEvent {}

//======================content_item_edit============================
class GetItemToEditEvent extends OrderStockTransferRegisterEvent {
  final OrderStockTransferItemModel item;
  GetItemToEditEvent({required this.item});
}

class SetItemUpdateEvent extends OrderStockTransferRegisterEvent {
  final OrderStockTransferItemModel item;
  SetItemUpdateEvent({required this.item});
}

class DeleteItemEvent extends OrderStockTransferRegisterEvent {
  OrderStockTransferItemModel item;
  DeleteItemEvent({
    required this.item,
  });
}
