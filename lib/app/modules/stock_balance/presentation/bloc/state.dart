import 'package:appweb/app/modules/Core/data/model/stock_balance_model.dart';
import 'package:appweb/app/modules/Core/data/model/stock_list_model.dart';

abstract class StockBalanceState {}

class LoadingState extends StockBalanceState {}

class StockListLoadedState extends StockBalanceState {
  final List<StockListModel> stockList;
  StockListLoadedState({
    required this.stockList,
  });
}

class StockBalanceListLoadedState extends StockBalanceState {
  final List<StockBalanceItemsModel> stockBalanceList;
  StockBalanceListLoadedState({
    required this.stockBalanceList,
  });
}

class StockErrorState extends StockBalanceState {
  final String message;
  StockErrorState({
    required this.message,
  });
}

class ErrorState extends StockBalanceState {
  final String message;
  ErrorState({
    required this.message,
  });
}
