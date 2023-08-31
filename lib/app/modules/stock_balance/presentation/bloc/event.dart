import 'package:appweb/app/modules/stock_balance/domain/usecase/get_stock_balance_list.dart';
import 'package:appweb/app/modules/stock_balance/domain/usecase/get_stock_list.dart';

abstract class StockBalanceEvent {}

//======================widget_stock_list============================
class GetStockListEvent extends StockBalanceEvent {
  ParamsStockList params;
  GetStockListEvent({required this.params});
}

class SearchStockEvent extends StockBalanceEvent {
  final ParamsStockList params;

  SearchStockEvent({required this.params});
}

class FilterStockEvent extends StockBalanceEvent {}

//======================widget_stock_balance_list============================
class GetStockBalanceListEvent extends StockBalanceEvent {
  ParamsStockBalanceList params;
  GetStockBalanceListEvent({required this.params});
}
