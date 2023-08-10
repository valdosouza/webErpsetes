import 'package:appweb/app/modules/Core/data/model/product_list_model.dart';
import 'package:appweb/app/modules/order_sale_register/data/model/customer_list_model.dart';
import 'package:appweb/app/modules/order_sale_register/data/model/order_main_model.dart';
import 'package:appweb/app/modules/order_sale_register/data/model/order_sale_list_model.dart';
import 'package:appweb/app/modules/order_sale_register/data/model/payment_types_list_model.dart';
import 'package:appweb/app/modules/order_sale_register/domain/usecase/get_customer_list.dart';
import 'package:appweb/app/modules/order_sale_register/domain/usecase/get_items_list.dart';
import 'package:appweb/app/modules/order_sale_register/domain/usecase/get_order_list.dart';
import 'package:appweb/app/modules/order_sale_register/domain/usecase/get_order_main.dart';
import 'package:appweb/app/modules/order_sale_register/domain/usecase/get_payment_types_list.dart';
import 'package:appweb/app/modules/order_sale_register/domain/usecase/get_product_list.dart';
import 'package:appweb/app/modules/order_sale_register/domain/usecase/get_product_prices.dart';
import 'package:appweb/app/modules/order_sale_register/presentation/bloc/event.dart';
import 'package:appweb/app/modules/order_sale_register/presentation/bloc/state.dart';
import 'package:bloc/bloc.dart';

class OrderSaleRegisterBloc
    extends Bloc<OrderSaleRegisterEvent, OrderSaleRegisterState> {
  final GetOrderList getOrderList;
  final GetOrderMain getOrderMain;
  final GetCustomerList getCustomerList;
  final GetPaymentTypesList getPaymentTypesList;
  final GetItemsList getItemsList;
  final GetProductList getProductList;
  final GetProductPrices getProductPrices;

  List<OrderSaleListModel> orderList = [];
  OrderMainModel orderMain = OrderMainModel.empty();

  List<CustomerListModel> customerList = [];
  List<CustomerListModel> customerListTemp = [];

  List<PaymentTypesListModel> paymentTypesList = [];

  List<ProductListModel> productList = [];
  List<ProductListModel> productListTemp = [];

  int pageCustomer = 1;
  int pagePaymentTypes = 1;
  int pageProduct = 1;

  String searchOrder = "";
  String searchCustomer = "";
  String searchPaymentType = "";
  String searchProduct = "";
  String searchItem = "";

  OrderSaleRegisterBloc({
    required this.getOrderList,
    required this.getOrderMain,
    required this.getCustomerList,
    required this.getPaymentTypesList,
    required this.getItemsList,
    required this.getProductList,
    required this.getProductPrices,
  }) : super(LoadingState()) {
    _getOrderList();
    _getFormOrder();
    _getFormItem();
    _getOrderMain();
    _getCustomerList();
    _getPaymentTypesList();
    _getItemsList();
    _getProductList();
    _getFormProductList();
    _getProductPrices();
    _getItemToEdit();
    _setitemsUpdate();
  }

  _getOrderList() {
    on<GetOrderListEvent>((event, emit) async {
      emit(LoadingState());

      var response = await getOrderList.call('');

      response.fold((l) => emit(ErrorState(message: l.toString())), (r) {
        orderList = r;
        emit(OrderListLoadedState(orderList: orderList));
      });
    });
  }

  _getFormOrder() {
    on<FormOrderEvent>((event, emit) async {
      emit(LoadingState());
      emit(FormOrderLoadedState(tbOrderId: event.tbOrderId));
    });
  }

  _getFormItem() {
    on<FormItemsEvent>((event, emit) async {
      emit(LoadingState());
      emit(FormItemsLoadedState(tbOrderId: event.tbOrderId));
    });
  }

  _getOrderMain() {
    on<GetOrderMainEvent>((event, emit) async {
      emit(LoadingState());
      if (event.tbOrderId == 0) {
      } else {
        var response = await getOrderMain.call(event.tbOrderId);

        response.fold((l) => emit(ErrorState(message: l.toString())), (r) {
          orderMain = r;
          emit(OrderListLoadedState(orderList: orderList));
        });
      }
    });
  }

  _getCustomerList() {
    on<GetCustomerListEvent>((event, emit) async {
      emit(LoadingState());
      if (event.params.page == 0) {
        customerList.clear();
        customerListTemp.clear;
        pageCustomer = 1;
      } else {
        pageCustomer += 1;
      }
      event.params.page = pageCustomer;
      var response = await getCustomerList.call(event.params);

      response.fold((l) => emit(ErrorState(message: l.toString())), (r) {
        customerList += r;
        emit(CustomerListLoadedState(customerList: customerList));
      });
    });
  }

  _getPaymentTypesList() {
    on<GetPaymentTypesListEvent>((event, emit) async {
      emit(LoadingState());
      var response = await getPaymentTypesList.call(event.params);

      response.fold((l) => emit(ErrorState(message: l.toString())), (r) {
        paymentTypesList = r;
        emit(PaymentTypesListLoadedSate(paymentTypesList: paymentTypesList));
      });
    });
  }

  _getItemsList() {
    on<GetItemsListEvent>((event, emit) async {
      emit(LoadingState());
      if (event.params.tbOrderId > 0) {
        var response = await getItemsList.call(event.params);

        response.fold((l) => emit(ErrorState(message: l.toString())), (r) {
          orderMain.items = r;
          emit(ItemsListLoadedSate(itemsList: orderMain.items));
        });
      } else {
        emit(ItemsListLoadedSate(itemsList: orderMain.items));
      }
    });
  }

  _getProductList() {
    on<GetProductListEvent>((event, emit) async {
      emit(LoadingState());
      if (event.params.page == 0) {
        productList.clear();
        productListTemp.clear;
        pageProduct = 1;
      } else {
        pageProduct += 1;
      }
      event.params.page = pageProduct;
      var response = await getProductList.call(event.params);

      response.fold((l) => emit(ErrorState(message: l.toString())), (r) {
        productList += r;
        emit(ProductListLoadedState(productList: productList));
      });
    });
  }

  _getFormProductList() {
    on<GetFormProductListEvent>((event, emit) async {
      emit(LoadingState());
      emit(ProductListLoadedState(productList: productList));
    });
  }

  _getProductPrices() {
    on<GetProductPricesEvent>((event, emit) async {
      emit(LoadingState());

      var response = await getProductPrices
          .call(ParamsProductPrices(tbProductId: event.tbProductId));

      response.fold((l) => emit(ErrorState(message: l.toString())), (r) {
        var productPrices = r;
        emit(ProductPricesLoadedState(productPrices: productPrices));
      });
    });
  }

  _getItemToEdit() {
    on<GetItemToEditEvent>((event, emit) async {
      emit(LoadingState());

      emit(GetItemToEditLoaded(itemEdit: event.itemEdit));
    });
  }

  _setitemsUpdate() {
    on<SetItemUpdateEvent>((event, emit) {
      if (event.itemEdit.id > 0) {
        event.itemEdit.updateStatus = "E";
        orderMain.items[orderMain.items
                .indexWhere((element) => element.id == event.itemEdit.id)] =
            event.itemEdit;
      } else {
        orderMain.items.add(event.itemEdit);
      }

      emit(SetItemUpdateSuccessState());
    });
  }
}
