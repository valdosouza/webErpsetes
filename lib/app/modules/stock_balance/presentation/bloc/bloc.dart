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
  List<StockBalanceItemsModel> stockBalanceList = [];
  int pageStockBalanceList = 0;

  String searchStockList = "";
  String searchMerchandise = "";

  int tbStockListId = 0;

  StockBalanceBloc({
    required this.getStockList,
    required this.getStockBalanceList,
  }) : super(LoadingState()) {
    _getStockList();
    _searchStockList();
    _filterStockList();
    _retunrStockList();

    _getStockBalanceList();
    _searchStockBalanceList();
    _filterStockBalanceList();
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

  _searchStockList() {
    on<SearchStockEvent>((event, emit) async {
      emit(LoadingState());
      if (event.params.page == 0) {
        stockList.clear();
        pageStockList = 1;
      } else {
        pageStockList += 1;
      }
      event.params.page = pageStockList;
      var response = await getStockList.call(event.params);

      response.fold((l) => emit(ErrorState(message: l.toString())), (r) {
        stockList = r;
        emit(StockListLoadedState(stockList: stockList));
      });
    });
  }

  _filterStockList() {
    on<FilterStockEvent>((event, emit) async {
      emit(LoadingState());
      List<StockListModel> stockListFilter = stockList;
      if (searchStockList.isNotEmpty) {
        stockListFilter = stockList.where((element) {
          String name = element.description;
          return name
              .toLowerCase()
              .trim()
              .contains(searchStockList.toLowerCase().trim());
        }).toList();
      }
      emit(StockListLoadedState(stockList: stockListFilter));
    });
  }

  _retunrStockList() {
    on<GetStockListReturnEvent>((event, emit) async {
      emit(LoadingState());
      emit(StockListLoadedState(stockList: stockList));
    });
  }

  _getStockBalanceList() {
    on<GetStockBalanceListEvent>((event, emit) async {
      emit(LoadingState());
      tbStockListId = event.params.tbStockListId!;

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

  _searchStockBalanceList() {
    on<SearchStockBalanceEvent>((event, emit) async {
      emit(LoadingState());
      if (event.params.page == 0) {
        stockBalanceList.clear();
        pageStockList = 1;
      } else {
        pageStockList += 1;
      }
      event.params.page = pageStockBalanceList;
      var response = await getStockBalanceList.call(event.params);

      response.fold((l) => emit(ErrorState(message: l.toString())), (r) {
        stockBalanceList = r;
        emit(StockBalanceListLoadedState(stockBalanceList: stockBalanceList));
      });
    });
  }

  _filterStockBalanceList() {
    on<FilterStockBalanceEvent>((event, emit) async {
      emit(LoadingState());
      List<StockBalanceItemsModel> stockBalanceListFilter = stockBalanceList;
      if (searchStockList.isNotEmpty) {
        stockBalanceListFilter = stockBalanceList.where((element) {
          String name = element.nameMerchandise;
          return name
              .toLowerCase()
              .trim()
              .contains(searchStockList.toLowerCase().trim());
        }).toList();
      }
      emit(StockBalanceListLoadedState(
          stockBalanceList: stockBalanceListFilter));
    });
  }
}
