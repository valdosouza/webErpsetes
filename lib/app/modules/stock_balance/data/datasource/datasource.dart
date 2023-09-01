import 'dart:convert';
import 'package:appweb/app/core/error/exceptions.dart';
import 'package:appweb/app/core/gateway.dart';
import 'package:appweb/app/modules/Core/data/model/stock_balance_model.dart';
import 'package:appweb/app/modules/Core/data/model/stock_list_model.dart';
import 'package:appweb/app/modules/stock_balance/domain/usecase/get_stock_balance_list.dart';
import 'package:appweb/app/modules/stock_balance/domain/usecase/get_stock_list.dart';
import 'package:flutter/foundation.dart';

abstract class DataSource extends Gateway {
  DataSource({required super.httpClient});

  Future<List<StockListModel>> getStockList({required ParamsStockList params});
  Future<List<StockBalanceItemsModel>> getStockBalancelist(
      {required ParamsStockBalanceList params});
}

class DataSourceImpl extends DataSource {
  List<StockListModel> stockList = [];
  List<StockBalanceItemsModel> stockBalanceList = [];

  DataSourceImpl({required super.httpClient});
  @override
  Future<List<StockListModel>> getStockList(
      {required ParamsStockList params}) async {
    await getInstitutionId().then((value) {
      (kIsWeb)
          ? params.tbInstitutionId = value
          : params.tbInstitutionId = int.parse(value);
    });
    final body = jsonEncode(params.toJson());
    return await request(
      'stocklist/getlist',
      method: HTTPMethod.post,
      data: body,
      (payload) {
        final data = json.decode(payload);

        if (data.length > 0) {
          stockList = (data as List).map((json) {
            return StockListModel.fromJson(json);
          }).toList();
        }
        return stockList;
      },
      onError: (error) {
        return ServerException;
      },
    );
  }

  @override
  Future<List<StockBalanceItemsModel>> getStockBalancelist(
      {required ParamsStockBalanceList params}) async {
    await getInstitutionId().then((value) {
      (kIsWeb)
          ? params.tbInstitutionId = value
          : params.tbInstitutionId = int.parse(value);
    });
    await getUserId().then((value) {
      (kIsWeb)
          ? params.tbSalesmanId = 0
          : params.tbSalesmanId = int.parse(value);
    });
    final body = jsonEncode(params.toJson());
    return await request(
      'stockbalance/getlist',
      method: HTTPMethod.post,
      data: body,
      (payload) {
        final data = json.decode(payload);

        if (data.length > 0) {
          stockBalanceList = (data['items'] as List).map((json) {
            return StockBalanceItemsModel.fromJson(json);
          }).toList();
        }
        return stockBalanceList;
      },
      onError: (error) {
        return ServerException;
      },
    );
  }
}
