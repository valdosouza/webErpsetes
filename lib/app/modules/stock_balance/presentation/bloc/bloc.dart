import 'package:appweb/app/modules/Core/data/model/stock_balance_model.dart';
import 'package:appweb/app/modules/Core/data/model/stock_list_model.dart';
import 'package:appweb/app/modules/stock_balance/domain/usecase/get_stock_balance_list.dart';
import 'package:appweb/app/modules/stock_balance/domain/usecase/get_stock_list.dart';

import 'package:appweb/app/modules/stock_balance/presentation/bloc/event.dart';
import 'package:appweb/app/modules/stock_balance/presentation/bloc/state.dart';
import 'package:bloc/bloc.dart';

class StockBalanceBloc extends Bloc<StockBalanceEvent, StockBalanceState> {
  final GetStockList getStockList;
  final GetStockBalanceList getStockBalanceList;

  List<StockListModel> stockList = [];
  int pageStockList = 0;
  List<StockBalanceModel> stockBalanceList = [];
  int pageStockBalanceList = 0;

  String searchStockList = "";
  String searchStockBalanceLsit = "";

  StockBalanceBloc({
    required this.getStockList,
    required this.getStockBalanceList,
  }) : super(LoadingState()) {
    _getStockList();
    _getStockBalanceList();
  }

  _getStockList() {
    on<GetStockListEvent>((event, emit) async {
      emit(LoadingState());

      if (event.params.page == 0) {
        stockList.clear();
        pageStockList = 1;
      } else {
        pageStockList += 1;
      }
      event.params.page = pageStockList;
      var response = await getStockList.call(event.params);

      response.fold((l) => emit(StockErrorState(message: l.toString())), (r) {
        stockList += r;
        emit(StockListLoadedState(stockList: stockList));
      });
    });
  }

  _getStockBalanceList() {
    on<GetStockBalanceListEvent>((event, emit) async {
      emit(LoadingState());

      if (event.params.page == 0) {
        stockBalanceList.clear();
        pageStockBalanceList = 1;
      } else {
        pageStockBalanceList += 1;
      }
      event.params.page = pageStockBalanceList;
      var response = await getStockBalanceList.call(event.params);

      response.fold((l) => emit(StockErrorState(message: l.toString())), (r) {
        stockBalanceList += r;
        emit(StockBalanceListLoadedState(stockBalanceList: stockBalanceList));
      });
    });
  }
}
