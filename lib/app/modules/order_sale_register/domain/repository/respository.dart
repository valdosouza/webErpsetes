import 'package:appweb/app/core/error/failures.dart';
import 'package:appweb/app/modules/Core/data/model/product_list_model.dart';
import 'package:appweb/app/modules/order_sale_register/data/model/customer_list_model.dart';
import 'package:appweb/app/modules/order_sale_register/data/model/items_model.dart';
import 'package:appweb/app/modules/order_sale_register/data/model/order_main_model.dart';
import 'package:appweb/app/modules/order_sale_register/data/model/order_sale_list_model.dart';
import 'package:appweb/app/modules/order_sale_register/data/model/payment_types_list_model.dart';
import 'package:appweb/app/modules/order_sale_register/data/model/product_prices_model.dart';
import 'package:appweb/app/modules/order_sale_register/domain/usecase/get_customer_list.dart';
import 'package:appweb/app/modules/order_sale_register/domain/usecase/get_items_list.dart';
import 'package:appweb/app/modules/order_sale_register/domain/usecase/get_product_list.dart';
import 'package:appweb/app/modules/order_sale_register/domain/usecase/get_payment_types_list.dart';
import 'package:appweb/app/modules/order_sale_register/domain/usecase/get_product_prices.dart';
import 'package:dartz/dartz.dart';

abstract class Repository {
  Future<Either<Failure, List<OrderSaleListModel>>> getOrderList();
  Future<Either<Failure, OrderMainModel>> getOrderMain(
      {required int tbOrderId});
  Future<Either<Failure, List<CustomerListModel>>> getCustomerList(
      {required ParamsCustomerList params});
  Future<Either<Failure, List<PaymentTypesListModel>>> getPaymentTypesList(
      {required ParamsPaymentList params});
  Future<Either<Failure, List<ItemsModel>>> getItemsList(
      {required ParamsItemsList params});
  Future<Either<Failure, List<ProductListModel>>> getProductList(
      {required ParamsProductList params});
  Future<Either<Failure, ProductPricesModel>> getProductPrices(
      {required ParamsProductPrices params});
}
