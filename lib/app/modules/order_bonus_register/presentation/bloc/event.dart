import 'package:appweb/app/modules/Core/data/model/order_bonus_item_model.dart';
import 'package:appweb/app/modules/order_bonus_register/domain/usecase/closure.dart';
import 'package:appweb/app/modules/order_bonus_register/domain/usecase/delete.dart';
import 'package:appweb/app/modules/order_bonus_register/domain/usecase/get_customer_list.dart';
import 'package:appweb/app/modules/order_bonus_register/domain/usecase/get_items_list.dart';
import 'package:appweb/app/modules/order_bonus_register/domain/usecase/get_order_list.dart';
import 'package:appweb/app/modules/order_bonus_register/domain/usecase/get_product_list.dart';
import 'package:appweb/app/modules/order_bonus_register/domain/usecase/get_stock_list.dart';
import 'package:appweb/app/modules/order_bonus_register/domain/usecase/reopen.dart';

abstract class OrderBonusRegisterEvent {}

//======================content_order_sale============================
class GetOrderListEvent extends OrderBonusRegisterEvent {
  ParamsOrderList params;
  GetOrderListEvent({required this.params});
}

class SearchOrderEvent extends OrderBonusRegisterEvent {
  final ParamsOrderList params;

  SearchOrderEvent({required this.params});
}

class FilterOrderEvent extends OrderBonusRegisterEvent {}

class NewFormOrderEvent extends OrderBonusRegisterEvent {}

class FormOrderEvent extends OrderBonusRegisterEvent {
  final int tbOrderId;
  FormOrderEvent({
    required this.tbOrderId,
  });
}

class GetOrderMainEvent extends OrderBonusRegisterEvent {
  final int tbOrderId;
  GetOrderMainEvent({
    required this.tbOrderId,
  });
}

class ReturnToOrderMainEvent extends OrderBonusRegisterEvent {}

class PostOrderEvent extends OrderBonusRegisterEvent {}

class PutOrderEvent extends OrderBonusRegisterEvent {}

class DeleteOrderEvent extends OrderBonusRegisterEvent {
  final ParamsDeleteOrder params;
  DeleteOrderEvent({
    required this.params,
  });
}

class ClosureOrderEvent extends OrderBonusRegisterEvent {
  final ParamsClosureOrder params;
  ClosureOrderEvent({
    required this.params,
  });
}

class ReopenOrderEvent extends OrderBonusRegisterEvent {
  final ParamsReopenOrder params;
  ReopenOrderEvent({
    required this.params,
  });
}

//======================widget_custoemr_list============================
class GetCustomerListEvent extends OrderBonusRegisterEvent {
  final ParamsCustomerList params;
  GetCustomerListEvent({required this.params});
}

class SearchCustomerEvent extends OrderBonusRegisterEvent {
  final ParamsCustomerList params;

  SearchCustomerEvent({required this.params});
}

class FilterCustomerEvent extends OrderBonusRegisterEvent {}

class FilterPaymentTypeEvent extends OrderBonusRegisterEvent {}

//======================widget_stock_list============================
class GetStockListEvent extends OrderBonusRegisterEvent {
  final ParamsStockList params;
  GetStockListEvent({required this.params});
}

class SearchStockEvent extends OrderBonusRegisterEvent {
  final ParamsStockList params;

  SearchStockEvent({required this.params});
}

class FilterStockEvent extends OrderBonusRegisterEvent {}

//======================content_items============================

class GetItemsListEvent extends OrderBonusRegisterEvent {
  final ParamsItemsList params;
  GetItemsListEvent({
    required this.params,
  });
}

class FormItemsEvent extends OrderBonusRegisterEvent {
  final int tbOrderId;
  FormItemsEvent({
    required this.tbOrderId,
  });
}

//======================widget_product_list============================

class GetProductListEvent extends OrderBonusRegisterEvent {
  final ParamsProductList params;
  GetProductListEvent({
    required this.params,
  });
}

class GetFormProductListEvent extends OrderBonusRegisterEvent {}

class SearchProductEvent extends OrderBonusRegisterEvent {
  final ParamsProductList params;

  SearchProductEvent({required this.params});
}

class FilterProductEvent extends OrderBonusRegisterEvent {}

//======================content_item_edit============================
class GetItemToEditEvent extends OrderBonusRegisterEvent {
  final OrderBonusItemModel item;
  GetItemToEditEvent({required this.item});
}

class SetItemUpdateEvent extends OrderBonusRegisterEvent {
  final OrderBonusItemModel item;
  SetItemUpdateEvent({required this.item});
}

class DeleteItemEvent extends OrderBonusRegisterEvent {
  OrderBonusItemModel item;
  DeleteItemEvent({
    required this.item,
  });
}
