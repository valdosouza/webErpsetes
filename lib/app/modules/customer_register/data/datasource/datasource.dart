import 'dart:convert';
import 'package:appweb/app/core/error/exceptions.dart';
import 'package:appweb/app/core/gateway.dart';
import 'package:appweb/app/modules/Core/data/model/customer_list_model.dart';
import 'package:appweb/app/modules/customer_register/data/model/customer_main_model.dart';
import 'package:appweb/app/modules/customer_register/domain/usecase/get_list.dart';
import 'package:flutter/foundation.dart';

abstract class DataSource extends Gateway {
  DataSource({required super.httpClient});

  Future<List<CustomerListModel>> getList({required ParamsList params});

  Future<CustomerMainModel> get({required int id});

  Future<CustomerListModel> post({required CustomerMainModel customer});
}

class DataSourceImpl extends DataSource {
  List<CustomerListModel> items = [];
  List<CustomerListModel> customerList = [];

  DataSourceImpl({required super.httpClient});

  @override
  Future<List<CustomerListModel>> getList({required ParamsList params}) async {
    await getInstitutionId().then((value) {
      params.tbInstitutionId = int.parse(value);
    });
    await getUserId().then((value) {
      params.tbSalesmanId = int.parse(value);
    });
    final body = jsonEncode(params.toJson());
    return await request(
      'customer/getlist',
      method: HTTPMethod.post,
      data: body,
      (payload) {
        final data = json.decode(payload);

        if (data.length > 0) {
          customerList = (data as List).map((json) {
            return CustomerListModel.fromJson(json);
          }).toList();
        }
        return customerList;
      },
      onError: (error) {
        return ServerException;
      },
    );
  }

  @override
  Future<CustomerMainModel> get({required int id}) async {
    String tbInstitutionId = '1';
    await getInstitutionId().then((value) {
      tbInstitutionId = value.toString();
    });

    return await request(
      'customer/get/$tbInstitutionId/$id',
      (payload) {
        final data = json.decode(payload);
        var model = CustomerMainModel.fromJson(data);
        return model;
      },
      onError: (error) {
        return Future.error(ServerException());
      },
    );
  }

  @override
  Future<CustomerListModel> post({
    required CustomerMainModel customer,
  }) async {
    int tbInstitutionId = 1;
    await getInstitutionId().then((value) {
      (kIsWeb) ? tbInstitutionId = value : tbInstitutionId = int.parse(value);
    });
    int tbUserId = 1;
    await getUserId().then((value) {
      (kIsWeb) ? tbUserId = value : tbUserId = int.parse(value);
    });
    customer.customer.tbInstitutionId = tbInstitutionId;
    customer.customer.tbSalesmanId = tbUserId;
    customer.fiscal.objEntity.tbInstitutionId = tbInstitutionId;

    var bodyCustomer = jsonEncode(customer.toJson());
    debugPrint(bodyCustomer);
    return await request(
      'customer',
      data: bodyCustomer,
      method: HTTPMethod.post,
      (payload) {
        final data = json.decode(payload);
        var model = CustomerListModel.fromJson(data);
        return model;
      },
      onError: (error) {
        return Future.error(ServerException());
      },
    );
  }
}
