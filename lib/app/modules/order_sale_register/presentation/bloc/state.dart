import 'package:appweb/app/modules/Core/data/model/order_sale_item_model.dart';
import 'package:appweb/app/modules/Core/data/model/product_list_model.dart';
import 'package:appweb/app/modules/Core/data/model/customer_list_model.dart';
import 'package:appweb/app/modules/order_sale_register/data/model/order_sale_list_model.dart';
import 'package:appweb/app/modules/order_sale_register/data/model/payment_types_list_model.dart';
import 'package:appweb/app/modules/order_sale_register/data/model/product_prices_model.dart';

abstract class OrderSaleRegisterState {}

class LoadingState extends OrderSaleRegisterState {}

class ErrorState extends OrderSaleRegisterState {
  final String message;
  ErrorState({
    required this.message,
  });
}

class OrderPostSuccessState extends OrderSaleRegisterState {
  final List<OrderSaleListModel> orderlist;
  OrderPostSuccessState({
    required this.orderlist,
  });
}

class OrderPutSuccessState extends OrderSaleRegisterState {}

class OrderDeleteSuccessState extends OrderSaleRegisterState {}

class OrderClosureSuccessState extends OrderSaleRegisterState {}

class OrderReopenSuccessState extends OrderSaleRegisterState {}

class OrderPostPutErrorState extends OrderSaleRegisterState {
  final String message;
  OrderPostPutErrorState({
    required this.message,
  });
}

class OrderDeleteErrorState extends OrderSaleRegisterState {
  final String message;
  OrderDeleteErrorState({
    required this.message,
  });
}

//======================content_order_list=======================
class OrderListLoadedState extends OrderSaleRegisterState {
  final List<OrderSaleListModel> orderList;
  OrderListLoadedState({required this.orderList});
}

//======================content_order============================
class FormOrderLoadedState extends OrderSaleRegisterState {
  final int tbOrderId;

  FormOrderLoadedState({required this.tbOrderId});
}

class OrderMainLoadedState extends OrderSaleRegisterState {}

//======================widget_customer_list============================
class CustomerListLoadedState extends OrderSaleRegisterState {
  final List<CustomerListModel> customerList;
  CustomerListLoadedState({
    required this.customerList,
  });
}

//======================widget_payment_types_list============================
class PaymentTypesListLoadedSate extends OrderSaleRegisterState {
  final List<PaymentTypesListModel> paymentTypesList;
  PaymentTypesListLoadedSate({
    required this.paymentTypesList,
  });
}

//======================widget_payment_types_list============================
class ItemsListLoadedSate extends OrderSaleRegisterState {
  final List<OrderSaleItemModel> itemsList;
  ItemsListLoadedSate({
    required this.itemsList,
  });
}

//======================content_items============================
class FormItemsLoadedState extends OrderSaleRegisterState {
  final int tbOrderId;

  FormItemsLoadedState({required this.tbOrderId});
}

//======================widget_product_list============================
class ProductListLoadedState extends OrderSaleRegisterState {
  final List<ProductListModel> productList;
  ProductListLoadedState({
    required this.productList,
  });
}

//======================widget_product_price============================
class ProductPricesLoadedState extends OrderSaleRegisterState {
  final ProductPricesModel productPrices;

  ProductPricesLoadedState({required this.productPrices});
}

//======================content_item_edit============================
class GetItemToEditLoaded extends OrderSaleRegisterState {
  final OrderSaleItemModel itemEdit;
  GetItemToEditLoaded({required this.itemEdit});
}

class SetItemInsertSuccessState extends OrderSaleRegisterState {}

class SetItemUpdateSuccessState extends OrderSaleRegisterState {
  final List<OrderSaleItemModel> itemsList;

  SetItemUpdateSuccessState({required this.itemsList});
}
