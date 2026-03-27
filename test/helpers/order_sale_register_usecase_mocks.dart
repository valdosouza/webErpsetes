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
import 'package:mocktail/mocktail.dart';

class MockGetOrderList extends Mock implements GetOrderList {}

class MockGetOrderMain extends Mock implements GetOrderMain {}

class MockGetCustomerList extends Mock implements GetCustomerList {}

class MockGetPaymentTypesList extends Mock implements GetPaymentTypesList {}

class MockGetItemsList extends Mock implements GetItemsList {}

class MockGetProductList extends Mock implements GetProductList {}

class MockGetProductPrices extends Mock implements GetProductPrices {}

class MockPost extends Mock implements Post {}

class MockPut extends Mock implements Put {}

class MockDelete extends Mock implements Delete {}

class MockClosure extends Mock implements Closure {}

class MockReopen extends Mock implements Reopen {}
