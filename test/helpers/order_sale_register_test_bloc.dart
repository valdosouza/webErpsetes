import 'package:appweb/app/modules/order_sale_register/presentation/bloc/bloc.dart';

import 'order_sale_register_usecase_mocks.dart';

/// Bloc with mocked use cases for widget tests (no HTTP / Modular).
OrderSaleRegisterBloc buildOrderSaleRegisterTestBloc() {
  return OrderSaleRegisterBloc(
    getOrderList: MockGetOrderList(),
    getOrderMain: MockGetOrderMain(),
    getCustomerList: MockGetCustomerList(),
    getPaymentTypesList: MockGetPaymentTypesList(),
    getItemsList: MockGetItemsList(),
    getProductList: MockGetProductList(),
    getProductPrices: MockGetProductPrices(),
    post: MockPost(),
    put: MockPut(),
    delete: MockDelete(),
    closure: MockClosure(),
    reopen: MockReopen(),
  );
}
