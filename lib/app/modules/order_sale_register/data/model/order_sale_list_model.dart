import 'package:appweb/app/core/shared/utils/custom_date.dart';
import 'package:appweb/app/modules/order_sale_register/domain/entity/order_sale_list_entity.dart';

class OrderSaleListModel extends OrderSaleListEntity {
  OrderSaleListModel({
    int? id,
    int? number,
    String? dtRecord,
    int? tbCustomerId,
    String? nameCustomer,
    String? docCustomer,
    int? tbSalesmanId,
    String? nameSalesman,
    String? docSalesman,
    String? status,
  }) : super(
          id: id ?? 0,
          number: number ?? 0,
          dtRecord: dtRecord ?? "",
          tbCustomerId: tbSalesmanId ?? 0,
          nameCustomer: nameCustomer ?? "",
          docCustomer: docCustomer ?? "",
          tbSalesmanId: tbSalesmanId ?? 0,
          nameSalesman: nameSalesman ?? "",
          docSalesman: docSalesman ?? "",
          status: status ?? "",
        );

  factory OrderSaleListModel.fromJson(Map<String, dynamic> json) {
    return OrderSaleListModel(
      id: json['id'],
      number: json['number'],
      dtRecord: CustomDate.formatDateIn(json['dt_record']),
      tbCustomerId: json['tb_customer_id'],
      nameCustomer: json['name_customer'],
      docCustomer: json['doc_customer'],
      tbSalesmanId: json['tb_salesman_id'],
      nameSalesman: json['name_salesman'],
      docSalesman: json['doc_salesman'],
      status: json['status'],
    );
  }

  factory OrderSaleListModel.empty() {
    return OrderSaleListModel();
  }
}
