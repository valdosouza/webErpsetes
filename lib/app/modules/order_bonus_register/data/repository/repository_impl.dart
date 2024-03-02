import 'package:appweb/app/modules/Core/data/model/customer_list_model.dart';
import 'package:appweb/app/modules/Core/data/model/order_result_action_model.dart';
import 'package:appweb/app/modules/Core/data/model/order_bonus_item_model.dart';
import 'package:appweb/app/modules/Core/data/model/product_list_model.dart';
import 'package:appweb/app/modules/Core/data/model/stock_list_model.dart';
import 'package:appweb/app/modules/order_bonus_register/data/model/order_main_model.dart';
import 'package:appweb/app/modules/order_bonus_register/domain/usecase/closure.dart';
import 'package:appweb/app/modules/order_bonus_register/domain/usecase/delete.dart';
import 'package:appweb/app/modules/order_bonus_register/domain/usecase/get_customer_list.dart';
import 'package:appweb/app/modules/order_bonus_register/domain/usecase/get_items_list.dart';
import 'package:appweb/app/modules/order_bonus_register/domain/usecase/get_order_list.dart';
import 'package:appweb/app/modules/order_bonus_register/domain/usecase/get_product_list.dart';
import 'package:appweb/app/modules/order_bonus_register/domain/usecase/get_stock_list.dart';
import 'package:appweb/app/modules/order_bonus_register/domain/usecase/reopen.dart';
import 'package:dartz/dartz.dart';
import 'package:appweb/app/core/error/exceptions.dart';
import 'package:appweb/app/core/error/failures.dart';
import 'package:appweb/app/modules/order_bonus_register/data/datasource/datasource.dart';
import 'package:appweb/app/modules/order_bonus_register/data/model/order_bonus_list_model.dart';
import 'package:appweb/app/modules/order_bonus_register/domain/repository/respository.dart';

class RepositoryImpl implements Repository {
  final DataSource datasource;
  RepositoryImpl({required this.datasource});

  @override
  Future<Either<Failure, List<OrderBonusListModel>>> getOrderList(
      {required ParamsOrderList params}) async {
    try {
      final list = await datasource.getOrderList(params: params);
      return Right(list);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, OrderBonusMainModel>> getOrderMain(
      {required int tbOrderId}) async {
    try {
      final orderMain = await datasource.getOrderMain(tbOrderId: tbOrderId);
      return Right(orderMain);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<CustomerListModel>>> getCustomerList(
      {required ParamsCustomerList params}) async {
    try {
      final list = await datasource.getCustomerList(params: params);
      return Right(list);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<StockListModel>>> getStockList(
      {required ParamsStockList params}) async {
    try {
      final list = await datasource.getStockList(params: params);
      return Right(list);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<OrderBonusItemModel>>> getItemsList(
      {required ParamsItemsList params}) async {
    try {
      final list = await datasource.getItemsList(params: params);
      return Right(list);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<ProductListModel>>> getProductList(
      {required ParamsProductList params}) async {
    try {
      final list = await datasource.getProductList(params: params);
      return Right(list);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, OrderBonusListModel>> post(
      {required OrderBonusMainModel params}) async {
    try {
      final order = await datasource.post(params: params);
      return Right(order);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, OrderBonusListModel>> put(
      {required OrderBonusMainModel params}) async {
    try {
      final order = await datasource.put(params: params);
      return Right(order);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, OrderResultActionModel>> delete(
      {required ParamsDeleteOrder params}) async {
    try {
      final result = await datasource.delete(params: params);
      return Right(result);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, OrderResultActionModel>> closure(
      {required ParamsClosureOrder params}) async {
    try {
      final result = await datasource.closure(params: params);
      return Right(result);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, OrderResultActionModel>> reopen(
      {required ParamsReopenOrder params}) async {
    try {
      final result = await datasource.reopen(params: params);
      return Right(result);
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
