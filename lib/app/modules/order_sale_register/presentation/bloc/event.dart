import 'package:appweb/app/modules/order_sale_register/data/model/items_model.dart';
import 'package:appweb/app/modules/order_sale_register/domain/usecase/get_customer_list.dart';
import 'package:appweb/app/modules/order_sale_register/domain/usecase/get_items_list.dart';
import 'package:appweb/app/modules/order_sale_register/domain/usecase/get_payment_types_list.dart';
import 'package:appweb/app/modules/order_sale_register/domain/usecase/get_product_list.dart';

abstract class OrderSaleRegisterEvent {}

//======================content_order_sale============================
class GetOrderListEvent extends OrderSaleRegisterEvent {}

class SearchOrderEvent extends OrderSaleRegisterEvent {}

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

//======================widget_customer_list============================
class GetCustomerListEvent extends OrderSaleRegisterEvent {
  final ParamsCustomerList params;
  GetCustomerListEvent({required this.params});
}

class SearchCustomerEvent extends OrderSaleRegisterEvent {}

//======================widget_payment_types_list============================
class GetPaymentTypesListEvent extends OrderSaleRegisterEvent {
  final ParamsPaymentList params;
  GetPaymentTypesListEvent({required this.params});
}

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

//======================widget_product_prices============================

class GetProductPricesEvent extends OrderSaleRegisterEvent {
  final int tbProductId;

  GetProductPricesEvent({required this.tbProductId});
}

//======================content_item_edit============================
class GetItemToEditEvent extends OrderSaleRegisterEvent {
  final ItemsModel itemEdit;
  GetItemToEditEvent({required this.itemEdit});
}

class SetItemUpdateEvent extends OrderSaleRegisterEvent {
  final ItemsModel itemEdit;
  SetItemUpdateEvent({required this.itemEdit});
}
