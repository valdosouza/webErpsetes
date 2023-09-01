import 'package:appweb/app/core/error/exceptions.dart';
import 'package:appweb/app/core/error/failures.dart';
import 'package:appweb/app/modules/Core/data/model/stock_balance_model.dart';
import 'package:appweb/app/modules/Core/data/model/stock_list_model.dart';
import 'package:appweb/app/modules/stock_balance/data/datasource/datasource.dart';
import 'package:appweb/app/modules/stock_balance/domain/repository/repository.dart';
import 'package:appweb/app/modules/stock_balance/domain/usecase/get_stock_balance_list.dart';
import 'package:appweb/app/modules/stock_balance/domain/usecase/get_stock_list.dart';
import 'package:dartz/dartz.dart';

class RepositoryImpl implements Repository {
  final DataSource datasource;

  RepositoryImpl({required this.datasource});
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
  Future<Either<Failure, List<StockBalanceItemsModel>>> getStockBalanceList(
      {required ParamsStockBalanceList params}) async {
    try {
      final list = await datasource.getStockBalancelist(params: params);
      return Right(list);
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
