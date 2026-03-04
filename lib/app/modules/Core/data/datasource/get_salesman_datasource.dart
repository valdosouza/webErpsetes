import 'dart:convert';
import 'package:appweb/app/core/error/exceptions.dart';
import 'package:appweb/app/core/gateway.dart';
import 'package:appweb/app/modules/Core/data/model/salesman_list_model.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';

abstract class GetSalesmanDatasource extends Gateway {
  GetSalesmanDatasource({required super.httpClient});

  Future<List<SalesmanListModel>> getSalesman();
}

class GetSalesmanDataSourceImpl extends GetSalesmanDatasource {
  List<SalesmanListModel> list = [];

  GetSalesmanDataSourceImpl({required super.httpClient});
  @override
  Future<List<SalesmanListModel>> getSalesman() async {
    try {
      String tbInstitutionId = '1';
      await getInstitutionId().then((value) {
        tbInstitutionId = value.toString();
      });

      return request(
        'collaborator/getlist/$tbInstitutionId',
        method: HTTPMethod.post,
        timeout: const Duration(milliseconds: 15000),
        (payload) {
          final data = json.decode(payload);
          list = (data as List).map((json) {
            return SalesmanListModel.fromJson(json);
          }).toList();
          return list;
        },
        onError: (e) async {
          return ServerException;
        },
      );
    } catch (e, s) {
      FirebaseCrashlytics.instance.recordError(e, s);
      throw ServerException();
    }
  }
}
