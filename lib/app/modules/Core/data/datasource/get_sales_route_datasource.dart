import 'dart:convert';
import 'package:appweb/app/core/error/exceptions.dart';
import 'package:appweb/app/core/gateway.dart';
import 'package:appweb/app/modules/Core/data/model/sales_route_list_model.dart';

abstract class GetSalesRouteDatasource extends Gateway {
  GetSalesRouteDatasource({required super.httpClient});

  Future<List<SalesRouteListModel>> getSalesRoute();
}

class GetSalesRouteDataSourceImpl extends GetSalesRouteDatasource {
  List<SalesRouteListModel> list = [];

  GetSalesRouteDataSourceImpl({required super.httpClient});
  @override
  Future<List<SalesRouteListModel>> getSalesRoute() async {
    String tbInstitutionId = '1';
    await getInstitutionId().then((value) {
      tbInstitutionId = value.toString();
    });

    return await request(
      'salesroute/getlist/$tbInstitutionId',
      (payload) {
        final data = json.decode(payload);
        list = (data as List).map((json) {
          return SalesRouteListModel.fromJson(json);
        }).toList();
        return list;
      },
      onError: (error) {
        return ServerException;
      },
    );
  }
}
