import 'package:appweb/app/modules/Core/data/model/order_sale_item_model.dart';
import 'package:appweb/app/modules/Core/data/model/product_list_model.dart';
import 'package:appweb/app/modules/order_sale_register/data/model/customer_list_model.dart';
import 'package:appweb/app/modules/order_sale_register/data/model/order_main_model.dart';
import 'package:appweb/app/modules/order_sale_register/data/model/payment_types_list_model.dart';
import 'package:appweb/app/modules/order_sale_register/data/model/product_prices_model.dart';
import 'package:appweb/app/modules/order_sale_register/domain/usecase/delete.dart';
import 'package:appweb/app/modules/order_sale_register/domain/usecase/get_customer_list.dart';
import 'package:appweb/app/modules/order_sale_register/domain/usecase/get_items_list.dart';
import 'package:appweb/app/modules/order_sale_register/domain/usecase/get_product_list.dart';
import 'package:appweb/app/modules/order_sale_register/domain/usecase/get_payment_types_list.dart';
import 'package:appweb/app/modules/order_sale_register/domain/usecase/get_product_prices.dart';
import 'package:dartz/dartz.dart';
import 'package:appweb/app/core/error/exceptions.dart';
import 'package:appweb/app/core/error/failures.dart';
import 'package:appweb/app/modules/order_sale_register/data/datasource/datasource.dart';
import 'package:appweb/app/modules/order_sale_register/data/model/order_sale_list_model.dart';
import 'package:appweb/app/modules/order_sale_register/domain/repository/respository.dart';

class RepositoryImpl implements Repository {
  final DataSource datasource;
  RepositoryImpl({required this.datasource});

  @override
  Future<Either<Failure, List<OrderSaleListModel>>> getOrderList() async {
    try {
      final list = await datasource.getOrderList();
      return Right(list);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, OrderSaleMainModel>> getOrderMain(
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
  Future<Either<Failure, List<PaymentTypesListModel>>> getPaymentTypesList(
      {required ParamsPaymentList params}) async {
    try {
      final list = await datasource.getPaymentTypesList(params: params);
      return Right(list);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<OrderSaleItemModel>>> getItemsList(
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
  Future<Either<Failure, ProductPricesModel>> getProductPrices(
      {required ParamsProductPrices params}) async {
    try {
      final list = await datasource.getProductPrices(params: params);
      return Right(list);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, OrderSaleListModel>> post(
      {required OrderSaleMainModel params}) async {
    try {
      final orderSale = await datasource.post(params: params);
      return Right(orderSale);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, OrderSaleListModel>> put(
      {required OrderSaleMainModel params}) async {
    try {
      final orderSale = await datasource.put(params: params);
      return Right(orderSale);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> delete(
      {required ParamsDeleteOrder params}) async {
    try {
      final result = await datasource.delete(params: params);
      return Right(result);
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
