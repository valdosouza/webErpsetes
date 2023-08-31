import 'package:appweb/app/modules/Core/data/model/order_stock_adjust_item_model.dart';
import 'package:appweb/app/modules/order_stock_adjust_register/domain/usecase/closure.dart';
import 'package:appweb/app/modules/order_stock_adjust_register/domain/usecase/delete.dart';
import 'package:appweb/app/modules/order_stock_adjust_register/domain/usecase/get_entity_list.dart';
import 'package:appweb/app/modules/order_stock_adjust_register/domain/usecase/get_items_list.dart';
import 'package:appweb/app/modules/order_stock_adjust_register/domain/usecase/get_order_list.dart';
import 'package:appweb/app/modules/order_stock_adjust_register/domain/usecase/get_product_list.dart';
import 'package:appweb/app/modules/order_stock_adjust_register/domain/usecase/get_stock_list.dart';
import 'package:appweb/app/modules/order_stock_adjust_register/domain/usecase/reopen.dart';

abstract class OrderStockAdjustRegisterEvent {}

//======================content_order_sale============================
class GetOrderListEvent extends OrderStockAdjustRegisterEvent {
  ParamsOrderList params;
  GetOrderListEvent({required this.params});
}

class SearchOrderEvent extends OrderStockAdjustRegisterEvent {
  final ParamsOrderList params;

  SearchOrderEvent({required this.params});
}

class FilterOrderEvent extends OrderStockAdjustRegisterEvent {}

class NewFormOrderEvent extends OrderStockAdjustRegisterEvent {}

class FormOrderEvent extends OrderStockAdjustRegisterEvent {
  final int tbOrderId;
  FormOrderEvent({
    required this.tbOrderId,
  });
}

class GetOrderMainEvent extends OrderStockAdjustRegisterEvent {
  final int tbOrderId;
  GetOrderMainEvent({
    required this.tbOrderId,
  });
}

class ReturnToOrderMainEvent extends OrderStockAdjustRegisterEvent {}

class PostOrderEvent extends OrderStockAdjustRegisterEvent {}

class PutOrderEvent extends OrderStockAdjustRegisterEvent {}

class DeleteOrderEvent extends OrderStockAdjustRegisterEvent {
  final ParamsDeleteOrder params;
  DeleteOrderEvent({
    required this.params,
  });
}

class ClosureOrderEvent extends OrderStockAdjustRegisterEvent {
  final ParamsClosureOrder params;
  ClosureOrderEvent({
    required this.params,
  });
}

class ReopenOrderEvent extends OrderStockAdjustRegisterEvent {
  final ParamsReopenOrder params;
  ReopenOrderEvent({
    required this.params,
  });
}

//======================widget_entity_list============================
class GetEntityListEvent extends OrderStockAdjustRegisterEvent {
  final ParamsEntityList params;
  GetEntityListEvent({required this.params});
}

class SearchEntityEvent extends OrderStockAdjustRegisterEvent {
  final ParamsEntityList params;

  SearchEntityEvent({required this.params});
}

class FilterEntityEvent extends OrderStockAdjustRegisterEvent {}

class FilterPaymentTypeEvent extends OrderStockAdjustRegisterEvent {}

//======================widget_stock_list============================
class GetStockListEvent extends OrderStockAdjustRegisterEvent {
  final ParamsStockList params;
  GetStockListEvent({required this.params});
}

class SearchStockEvent extends OrderStockAdjustRegisterEvent {
  final ParamsStockList params;

  SearchStockEvent({required this.params});
}

class FilterStockEvent extends OrderStockAdjustRegisterEvent {}

//======================content_items============================

class GetItemsListEvent extends OrderStockAdjustRegisterEvent {
  final ParamsItemsList params;
  GetItemsListEvent({
    required this.params,
  });
}

class FormItemsEvent extends OrderStockAdjustRegisterEvent {
  final int tbOrderId;
  FormItemsEvent({
    required this.tbOrderId,
  });
}

//======================widget_product_list============================

class GetProductListEvent extends OrderStockAdjustRegisterEvent {
  final ParamsProductList params;
  GetProductListEvent({
    required this.params,
  });
}

class GetFormProductListEvent extends OrderStockAdjustRegisterEvent {}

class SearchProductEvent extends OrderStockAdjustRegisterEvent {
  final ParamsProductList params;

  SearchProductEvent({required this.params});
}

class FilterProductEvent extends OrderStockAdjustRegisterEvent {}

//======================content_item_edit============================
class GetItemToEditEvent extends OrderStockAdjustRegisterEvent {
  final OrderStockAdjustItemModel item;
  GetItemToEditEvent({required this.item});
}

class SetItemUpdateEvent extends OrderStockAdjustRegisterEvent {
  final OrderStockAdjustItemModel item;
  SetItemUpdateEvent({required this.item});
}

class DeleteItemEvent extends OrderStockAdjustRegisterEvent {
  OrderStockAdjustItemModel item;
  DeleteItemEvent({
    required this.item,
  });
}
