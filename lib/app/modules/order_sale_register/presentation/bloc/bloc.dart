import 'package:appweb/app/modules/Core/data/model/order_sale_item_model.dart';
import 'package:appweb/app/modules/Core/data/model/product_list_model.dart';
import 'package:appweb/app/modules/Core/data/model/customer_list_model.dart';
import 'package:appweb/app/modules/order_sale_register/data/model/order_main_model.dart';
import 'package:appweb/app/modules/order_sale_register/data/model/order_sale_list_model.dart';
import 'package:appweb/app/modules/order_sale_register/data/model/payment_types_list_model.dart';
import 'package:appweb/app/modules/order_sale_register/domain/usecase/closure.dart';
import 'package:appweb/app/modules/order_sale_register/domain/usecase/delete.dart';
import 'package:appweb/app/modules/order_sale_register/domain/usecase/get_customer_list.dart';
import 'package:appweb/app/modules/order_sale_register/domain/usecase/get_items_list.dart';
import 'package:appweb/app/modules/order_sale_register/domain/usecase/get_order_list.dart';
import 'package:appweb/app/modules/order_sale_register/domain/usecase/get_order_main.dart';
import 'package:appweb/app/modules/order_sale_register/domain/usecase/get_payment_types_list.dart';
import 'package:appweb/app/modules/order_sale_register/domain/usecase/get_product_list.dart';
import 'package:appweb/app/modules/order_sale_register/domain/usecase/get_product_prices.dart';
import 'package:appweb/app/modules/order_sale_register/domain/usecase/post.dart';
import 'package:appweb/app/modules/order_sale_register/domain/usecase/put.dart';
import 'package:appweb/app/modules/order_sale_register/domain/usecase/reopen.dart';
import 'package:appweb/app/modules/order_sale_register/presentation/bloc/event.dart';
import 'package:appweb/app/modules/order_sale_register/presentation/bloc/state.dart';
import 'package:bloc/bloc.dart';
import 'dart:developer' as developer;
import 'package:firebase_analytics/firebase_analytics.dart';

class OrderSaleRegisterBloc
    extends Bloc<OrderSaleRegisterEvent, OrderSaleRegisterState> {
  final GetOrderList getOrderList;
  final GetOrderMain getOrderMain;
  final GetCustomerList getCustomerList;
  final GetPaymentTypesList getPaymentTypesList;
  final GetItemsList getItemsList;
  final GetProductList getProductList;
  final GetProductPrices getProductPrices;
  final Post post;
  final Put put;
  final Delete delete;
  final Closure closure;
  final Reopen reopen;

  List<OrderSaleListModel> orderList = [];
  OrderSaleMainModel orderMain = OrderSaleMainModel.empty();

  List<CustomerListModel> customerList = [];

  List<PaymentTypesListModel> paymentTypesList = [];

  List<ProductListModel> productList = [];

  int pageOrder = 1;
  int pageCustomer = 1;
  int pagePaymentTypes = 1;
  int pageProduct = 1;

  String searchOrder = "";
  String searchCustomer = "";
  String searchPaymentType = "";
  String searchProduct = "";
  String searchItem = "";

  int indexDeleteOrder = 0;
  OrderSaleItemModel elementItemDelete = OrderSaleItemModel.empty();

  FirebaseAnalytics analytics = FirebaseAnalytics.instance;

  OrderSaleRegisterBloc({
    required this.getOrderList,
    required this.getOrderMain,
    required this.getCustomerList,
    required this.getPaymentTypesList,
    required this.getItemsList,
    required this.getProductList,
    required this.getProductPrices,
    required this.post,
    required this.put,
    required this.delete,
    required this.closure,
    required this.reopen,
  }) : super(LoadingState()) {
    _getOrderList();
    _searchOrderList();
    _filterOrderList();
    _returnOrderList();
    _getNewFormOrder();
    _getFormOrder();
    _getFormItem();
    _getOrderMain();
    _getCustomerList();
    _searchCustomerList();
    _filterCustomerList();
    _getPaymentTypesList();
    _filterPaymentTypesList();
    _getItemsList();
    _getProductList();
    _searchProductList();
    _filterProductList();
    _getFormProductList();
    _getProductPrices();
    _getItemToEdit();
    _deleteItem();
    _setitemsUpdate();
    _post();
    _put();
    _delete();
    _closure();
    _reopen();
  }

  _getOrderList() {
    on<GetOrderListEvent>((event, emit) async {
      emit(LoadingState());
      if (event.params.page == 0) {
        orderList.clear();
        pageOrder = 1;
      } else {
        pageOrder += 1;
      }
      event.params.page = pageOrder;
      var response = await getOrderList.call(event.params);

      response.fold((l) => emit(ErrorState(message: l.toString())), (r) {
        orderList += r;
        emit(OrderListLoadedState(orderList: orderList));
      });
    });
  }

  _searchOrderList() {
    on<SearchOrderEvent>((event, emit) async {
      emit(LoadingState());
      if (event.params.page == 0) {
        orderList.clear();
        pageOrder = 1;
      } else {
        pageOrder += 1;
      }
      event.params.page = pageOrder;
      var response = await getOrderList.call(event.params);

      response.fold((l) => emit(ErrorState(message: l.toString())), (r) {
        orderList = r;
        emit(OrderListLoadedState(orderList: orderList));
      });
    });
  }

  _filterOrderList() {
    on<FilterOrderEvent>((event, emit) async {
      emit(LoadingState());
      List<OrderSaleListModel> orderListFilter = orderList;
      if (searchOrder.isNotEmpty) {
        orderListFilter = orderList.where((element) {
          String name = element.nameCustomer;
          return name
              .toLowerCase()
              .trim()
              .contains(searchOrder.toLowerCase().trim());
        }).toList();
      }
      emit(OrderListLoadedState(orderList: orderListFilter));
    });
  }

  _returnOrderList() {
    on<ReturnToOrderMainEvent>((event, emit) async {
      emit(LoadingState());
      emit(OrderListLoadedState(orderList: orderList));
    });
  }

  _getNewFormOrder() {
    on<NewFormOrderEvent>((event, emit) async {
      emit(LoadingState());
      orderMain = OrderSaleMainModel.empty();
      emit(FormOrderLoadedState(tbOrderId: 0));
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
        orderMain = OrderSaleMainModel.empty();
      } else {
        var response = await getOrderMain.call(event.tbOrderId);

        response.fold((l) => emit(ErrorState(message: l.toString())), (r) {
          orderMain = r;
          emit(OrderMainLoadedState());
        });
      }
    });
  }

  _getCustomerList() {
    on<GetCustomerListEvent>((event, emit) async {
      emit(LoadingState());
      if (event.params.page == 0) {
        customerList.clear();
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

  _searchCustomerList() {
    on<SearchCustomerEvent>((event, emit) async {
      emit(LoadingState());
      if (event.params.page == 0) {
        customerList.clear();
        pageCustomer = 1;
      } else {
        pageCustomer += 1;
      }
      event.params.page = pageCustomer;
      var response = await getCustomerList.call(event.params);

      response.fold((l) => emit(ErrorState(message: l.toString())), (r) {
        customerList = r;
        emit(CustomerListLoadedState(customerList: customerList));
      });
    });
  }

  _filterCustomerList() {
    on<FilterCustomerEvent>((event, emit) async {
      emit(LoadingState());
      List<CustomerListModel> customerListFilter = customerList;
      if (searchCustomer.isNotEmpty) {
        customerListFilter = customerList.where((element) {
          String name = element.nickTrade;
          return name
              .toLowerCase()
              .trim()
              .contains(searchCustomer.toLowerCase().trim());
        }).toList();
      }
      emit(CustomerListLoadedState(customerList: customerListFilter));
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

  _filterPaymentTypesList() {
    on<FilterPaymentTypeEvent>((event, emit) async {
      emit(LoadingState());
      var paymentTypeListFilter = paymentTypesList.where((element) {
        String name = element.description;
        return name
            .toLowerCase()
            .trim()
            .contains(searchPaymentType.toLowerCase().trim());
      }).toList();
      emit(PaymentTypesListLoadedSate(paymentTypesList: paymentTypeListFilter));
    });
  }

  _getItemsList() {
    on<GetItemsListEvent>((event, emit) async {
      emit(LoadingState());
      emit(ItemsListLoadedSate(itemsList: orderMain.items));
    });
  }

  _getProductList() {
    on<GetProductListEvent>((event, emit) async {
      emit(LoadingState());
      if (event.params.page == 0) {
        productList.clear();
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

  _searchProductList() {
    on<SearchProductEvent>((event, emit) async {
      emit(LoadingState());
      if (event.params.page == 0) {
        productList.clear();
        pageProduct = 1;
      } else {
        pageProduct += 1;
      }
      event.params.page = pageProduct;
      var response = await getProductList.call(event.params);

      response.fold((l) => emit(ErrorState(message: l.toString())), (r) {
        productList = r;
        emit(ProductListLoadedState(productList: productList));
      });
    });
  }

  _filterProductList() {
    on<FilterProductEvent>((event, emit) async {
      emit(LoadingState());
      List<ProductListModel> productListFilter = productList;
      if (searchProduct.isNotEmpty) {
        productListFilter = productList.where((element) {
          String name = element.description;
          return name
              .toLowerCase()
              .trim()
              .contains(searchProduct.toLowerCase().trim());
        }).toList();
      }
      emit(ProductListLoadedState(productList: productListFilter));
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

      emit(GetItemToEditLoaded(itemEdit: event.item));
    });
  }

  _deleteItem() {
    on<DeleteItemEvent>((event, emit) async {
      emit(LoadingState());

      orderMain
          .items[orderMain.items.indexWhere((element) => element == event.item)]
          .updateStatus = "D";

      emit(ItemsListLoadedSate(itemsList: orderMain.items));
    });
  }

  _setitemsUpdate() {
    on<SetItemUpdateEvent>((event, emit) {
      if (event.item.id > 0) {
        event.item.updateStatus = "E";
      }
      int index = orderMain.items.indexWhere(
          (element) => element.tbProductId == event.item.tbProductId);
      if (index == -1) {
        orderMain.items.add(event.item);
        emit(SetItemInsertSuccessState());
      } else {
        orderMain.items[index] = event.item;
        emit(SetItemUpdateSuccessState(itemsList: orderMain.items));
      }
    });
  }

  _post() {
    on<PostOrderEvent>((event, emit) async {
      emit(LoadingState());

      var response = await post.call(orderMain);

      response.fold((l) {
        emit(OrderPostPutErrorState(message: l.toString()));
      }, (r) {
        orderList.insert(0, r);
        emit(OrderPostSuccessState(orderlist: orderList));
      });
    });
  }

  _put() {
    on<PutOrderEvent>((event, emit) async {
      emit(LoadingState());

      var response = await put.call(orderMain);

      response.fold((l) {
        emit(OrderPostPutErrorState(message: l.toString()));
      }, (r) {
        orderList[orderList.indexWhere((element) => element.id == r.id)] = r;
        emit(OrderPutSuccessState());
      });
    });
  }

  _delete() {
    on<DeleteOrderEvent>((event, emit) async {
      emit(LoadingState());
      final orderId = event.params.tbOrderId;
      var response = await delete.call(event.params);

      response.fold((l) {
        emit(ErrorState(message: l.toString()));
      }, (r) {
        if (r.result) {
          orderList.removeWhere((element) => element.id == orderId);
        }
        emit(OrderDeleteSuccessState());
      });
    });
  }

  _closure() {
    on<ClosureOrderEvent>((event, emit) async {
      await FirebaseAnalytics.instance.logEvent(
        name: "order_sale",
        parameters: {
          "bloc": "_closure",
          "log": "Antes do loading",
        },
      );
      emit(LoadingState());
      await FirebaseAnalytics.instance.logEvent(
        name: "order_sale",
        parameters: {
          "bloc": "_closure",
          "log": "Atribui o codigo de ordem",
        },
      );

      final orderId = event.params.tbOrderId;
      await FirebaseAnalytics.instance.logEvent(
        name: "order_sale",
        parameters: {
          "bloc": "_closure",
          "log": "Chama o closure.all",
        },
      );
      var response = await closure.call(event.params);
      await FirebaseAnalytics.instance.logEvent(
        name: "order_sale",
        parameters: {
          "bloc": "_closure",
          "log": "Response.fold (l): ${response.fold.toString()}",
        },
      );

      response.fold((l) {
        emit(ErrorState(message: l.toString()));
      }, (r) {
        developer.log('Resultado: ${r.result}');
        if (r.result) {
          orderList[orderList.indexWhere((element) => element.id == orderId)]
              .status = "F";
        }
        emit(OrderClosureSuccessState());
      });
    });
  }

  _reopen() {
    on<ReopenOrderEvent>((event, emit) async {
      emit(LoadingState());
      final orderId = event.params.tbOrderId;
      var response = await reopen.call(event.params);

      response.fold((l) {
        emit(ErrorState(message: l.toString()));
      }, (r) {
        if (r.result) {
          orderList[orderList.indexWhere((element) => element.id == orderId)]
              .status = "A";
        }
        emit(OrderClosureSuccessState());
      });
    });
  }
}
