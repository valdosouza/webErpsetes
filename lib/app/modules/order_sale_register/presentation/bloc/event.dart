import 'package:appweb/app/modules/Core/data/model/order_sale_item_model.dart';
import 'package:appweb/app/modules/order_sale_register/domain/usecase/closure.dart';
import 'package:appweb/app/modules/order_sale_register/domain/usecase/delete.dart';
import 'package:appweb/app/modules/order_sale_register/domain/usecase/get_customer_list.dart';
import 'package:appweb/app/modules/order_sale_register/domain/usecase/get_items_list.dart';
import 'package:appweb/app/modules/order_sale_register/domain/usecase/get_order_list.dart';
import 'package:appweb/app/modules/order_sale_register/domain/usecase/get_payment_types_list.dart';
import 'package:appweb/app/modules/order_sale_register/domain/usecase/get_product_list.dart';
import 'package:appweb/app/modules/order_sale_register/domain/usecase/reopen.dart';

abstract class OrderSaleRegisterEvent {}

//======================content_order_sale============================
class GetOrderListEvent extends OrderSaleRegisterEvent {
  ParamsOrderList params;
  GetOrderListEvent({required this.params});
}

class SearchOrderEvent extends OrderSaleRegisterEvent {
  final ParamsOrderList params;

  SearchOrderEvent({required this.params});
}

class FilterOrderEvent extends OrderSaleRegisterEvent {}

class NewFormOrderEvent extends OrderSaleRegisterEvent {}

class FormOrderEvent extends OrderSaleRegisterEvent {
  final int tbOrderId;
  FormOrderEvent({
    required this.tbOrderId,
  });
}

class GetOrderMainEvent extends OrderSaleRegisterEvent {
  final int tbOrderId;
  GetOrderMainEvent({
    required this.tbOrderId,
  });
}

class ReturnToOrderMainEvent extends OrderSaleRegisterEvent {}

class PostOrderEvent extends OrderSaleRegisterEvent {}

class PutOrderEvent extends OrderSaleRegisterEvent {}

class DeleteOrderEvent extends OrderSaleRegisterEvent {
  final ParamsDeleteOrder params;
  DeleteOrderEvent({
    required this.params,
  });
}

class ClosureOrderEvent extends OrderSaleRegisterEvent {
  final ParamsClosureOrder params;
  ClosureOrderEvent({
    required this.params,
  });
}

class ReopenOrderEvent extends OrderSaleRegisterEvent {
  final ParamsReopenOrder params;
  ReopenOrderEvent({
    required this.params,
  });
}

//======================widget_customer_list============================
class GetCustomerListEvent extends OrderSaleRegisterEvent {
  final ParamsCustomerList params;
  GetCustomerListEvent({required this.params});
}

class SearchCustomerEvent extends OrderSaleRegisterEvent {
  final ParamsCustomerList params;

  SearchCustomerEvent({required this.params});
}

class FilterCustomerEvent extends OrderSaleRegisterEvent {}

//======================widget_payment_types_list============================
class GetPaymentTypesListEvent extends OrderSaleRegisterEvent {
  final ParamsPaymentList params;
  GetPaymentTypesListEvent({required this.params});
}

class FilterPaymentTypeEvent extends OrderSaleRegisterEvent {}
//======================content_items============================

class GetItemsListEvent extends OrderSaleRegisterEvent {
  final ParamsItemsList params;
  GetItemsListEvent({
    required this.params,
  });
}

class FormItemsEvent extends OrderSaleRegisterEvent {
  final int tbOrderId;
  FormItemsEvent({
    required this.tbOrderId,
  });
}

//======================widget_product_list============================

class GetProductListEvent extends OrderSaleRegisterEvent {
  final ParamsProductList params;
  GetProductListEvent({
    required this.params,
  });
}

class GetFormProductListEvent extends OrderSaleRegisterEvent {}

class SearchProductEvent extends OrderSaleRegisterEvent {
  final ParamsProductList params;

  SearchProductEvent({required this.params});
}

class FilterProductEvent extends OrderSaleRegisterEvent {}

//======================widget_product_prices============================

class GetProductPricesEvent extends OrderSaleRegisterEvent {
  final int tbProductId;

  GetProductPricesEvent({required this.tbProductId});
}

//======================content_item_edit============================
class GetItemToEditEvent extends OrderSaleRegisterEvent {
  final OrderSaleItemModel item;
  GetItemToEditEvent({required this.item});
}

class SetItemUpdateEvent extends OrderSaleRegisterEvent {
  final OrderSaleItemModel item;
  SetItemUpdateEvent({required this.item});
}

class DeleteItemEvent extends OrderSaleRegisterEvent {
  OrderSaleItemModel item;
  DeleteItemEvent({
    required this.item,
  });
}
