import 'package:appweb/app/modules/Core/data/model/fiscal_model.dart';
import 'package:appweb/app/modules/customer_register/data/model/customer_model.dart';
import 'package:appweb/app/modules/customer_register/domain/entity/customer_main_entity.dart';

class CustomerMainModel extends CustomerMainEntity {
  CustomerMainModel({
    required CustomerModel customer,
    required FiscalModel fiscal,
  }) : super(
          customer: customer,
          fiscal: fiscal,
        );

  factory CustomerMainModel.fromJson(Map<String, dynamic> json) {
    return CustomerMainModel(
      customer: CustomerModel.fromJson(json['customer']),
      fiscal: FiscalModel.fromJson(json['fiscal']),
    );
  }

  Map<dynamic, dynamic> toJson() {
    final Map<dynamic, dynamic> data = <dynamic, dynamic>{};
    data['customer'] = customer.toJson();
    data['fiscal'] = fiscal.toJson();
    return data;
  }

  factory CustomerMainModel.empty() {
    return CustomerMainModel(
      customer: CustomerModel.empty(),
      fiscal: FiscalModel.empty(),
    );
  }
}
