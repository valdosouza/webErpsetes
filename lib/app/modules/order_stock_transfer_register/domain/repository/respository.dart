import 'package:appweb/app/core/error/failures.dart';
import 'package:appweb/app/modules/Core/data/model/order_result_action_model.dart';
import 'package:appweb/app/modules/Core/data/model/order_stock_transfer_item_model.dart';
import 'package:appweb/app/modules/Core/data/model/product_list_model.dart';
import 'package:appweb/app/modules/order_stock_transfer_register/data/model/entity_list_model.dart';
import 'package:appweb/app/modules/order_stock_transfer_register/data/model/order_main_model.dart';
import 'package:appweb/app/modules/order_stock_transfer_register/data/model/order_stock_transfer_list_model.dart';
import 'package:appweb/app/modules/order_stock_transfer_register/domain/usecase/closure.dart';
import 'package:appweb/app/modules/order_stock_transfer_register/domain/usecase/delete.dart';
import 'package:appweb/app/modules/order_stock_transfer_register/domain/usecase/get_entity_list.dart';
import 'package:appweb/app/modules/order_stock_transfer_register/domain/usecase/get_items_list.dart';
import 'package:appweb/app/modules/order_stock_transfer_register/domain/usecase/get_order_list.dart';
import 'package:appweb/app/modules/order_stock_transfer_register/domain/usecase/get_product_list.dart';
import 'package:appweb/app/modules/order_stock_transfer_register/domain/usecase/reopen.dart';

import 'package:dartz/dartz.dart';

abstract class Repository {
  Future<Either<Failure, List<OrderStockTransferListModel>>> getOrderList(
      {required ParamsOrderList params});

  Future<Either<Failure, OrderStockTransferMainModel>> getOrderMain(
      {required int tbOrderId});

  Future<Either<Failure, List<EntityListModel>>> getEntityList(
      {required ParamsEntityList params});

  Future<Either<Failure, List<OrderStockTransferItemModel>>> getItemsList(
      {required ParamsItemsList params});

  Future<Either<Failure, List<ProductListModel>>> getProductList(
      {required ParamsProductList params});

  Future<Either<Failure, OrderStockTransferListModel>> post(
      {required OrderStockTransferMainModel params});

  Future<Either<Failure, OrderStockTransferListModel>> put(
      {required OrderStockTransferMainModel params});

  Future<Either<Failure, OrderResultActionModel>> delete(
      {required ParamsDeleteOrder params});

  Future<Either<Failure, OrderResultActionModel>> closure(
      {required ParamsClosureOrder params});

  Future<Either<Failure, OrderResultActionModel>> reopen(
      {required ParamsReopenOrder params});
}
