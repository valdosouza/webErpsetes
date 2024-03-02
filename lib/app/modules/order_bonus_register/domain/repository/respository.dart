import 'package:appweb/app/core/error/failures.dart';
import 'package:appweb/app/modules/Core/data/model/customer_list_model.dart';
import 'package:appweb/app/modules/Core/data/model/order_result_action_model.dart';
import 'package:appweb/app/modules/Core/data/model/order_bonus_item_model.dart';
import 'package:appweb/app/modules/Core/data/model/product_list_model.dart';
import 'package:appweb/app/modules/Core/data/model/stock_list_model.dart';
import 'package:appweb/app/modules/order_bonus_register/data/model/order_main_model.dart';
import 'package:appweb/app/modules/order_bonus_register/data/model/order_bonus_list_model.dart';
import 'package:appweb/app/modules/order_bonus_register/domain/usecase/closure.dart';
import 'package:appweb/app/modules/order_bonus_register/domain/usecase/delete.dart';
import 'package:appweb/app/modules/order_bonus_register/domain/usecase/get_customer_list.dart';
import 'package:appweb/app/modules/order_bonus_register/domain/usecase/get_items_list.dart';
import 'package:appweb/app/modules/order_bonus_register/domain/usecase/get_order_list.dart';
import 'package:appweb/app/modules/order_bonus_register/domain/usecase/get_product_list.dart';
import 'package:appweb/app/modules/order_bonus_register/domain/usecase/get_stock_list.dart';
import 'package:appweb/app/modules/order_bonus_register/domain/usecase/reopen.dart';

import 'package:dartz/dartz.dart';

abstract class Repository {
  Future<Either<Failure, List<OrderBonusListModel>>> getOrderList(
      {required ParamsOrderList params});

  Future<Either<Failure, OrderBonusMainModel>> getOrderMain(
      {required int tbOrderId});

  Future<Either<Failure, List<CustomerListModel>>> getCustomerList(
      {required ParamsCustomerList params});

  Future<Either<Failure, List<StockListModel>>> getStockList(
      {required ParamsStockList params});

  Future<Either<Failure, List<OrderBonusItemModel>>> getItemsList(
      {required ParamsItemsList params});

  Future<Either<Failure, List<ProductListModel>>> getProductList(
      {required ParamsProductList params});

  Future<Either<Failure, OrderBonusListModel>> post(
      {required OrderBonusMainModel params});

  Future<Either<Failure, OrderBonusListModel>> put(
      {required OrderBonusMainModel params});

  Future<Either<Failure, OrderResultActionModel>> delete(
      {required ParamsDeleteOrder params});

  Future<Either<Failure, OrderResultActionModel>> closure(
      {required ParamsClosureOrder params});

  Future<Either<Failure, OrderResultActionModel>> reopen(
      {required ParamsReopenOrder params});
}
