import 'package:appweb/app/modules/Core/data/model/fiscal_model.dart';
import 'package:appweb/app/modules/customer_register/data/model/customer_model.dart';

class CustomerMainEntity {
  CustomerModel customer;
  FiscalModel fiscal;
  CustomerMainEntity({
    required this.customer,
    required this.fiscal,
  });
}
