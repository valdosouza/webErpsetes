import 'package:appweb/app/core/error/failures.dart';
import 'package:appweb/app/modules/Core/data/model/stock_balance_model.dart';
import 'package:appweb/app/modules/Core/data/model/stock_list_model.dart';
import 'package:appweb/app/modules/stock_balance/domain/usecase/get_stock_balance_list.dart';
import 'package:appweb/app/modules/stock_balance/domain/usecase/get_stock_list.dart';
import 'package:dartz/dartz.dart';

abstract class Repository {
  Future<Either<Failure, List<StockListModel>>> getStockList(
      {required ParamsStockList params});
  Future<Either<Failure, List<StockBalanceModel>>> getStockBalanceList(
      {required ParamsStockBalanceList params});
}
