import 'package:appweb/app/modules/Core/domain/entity/order_sale_entity.dart';

class OrderSaleModel extends OrderSaleEntity {
  OrderSaleModel({
    int? number,
    int? tbCustomerId,
    String? nameCustomer,
    String? docCustomer,
    int? tbSalesmanId,
    String? nameSalesman,
    String? docSalesman,
  }) : super(
          number: number ?? 0,
          tbCustomerId: tbCustomerId ?? 0,
          nameCustomer: nameCustomer ?? "",
          docCustomer: docCustomer ?? "",
          tbSalesmanId: tbSalesmanId ?? 0,
          nameSalesman: nameSalesman ?? "",
          docSalesman: docSalesman ?? "",
        );

  factory OrderSaleModel.fromJson(Map<String, dynamic> json) {
    return OrderSaleModel(
      number: json['number'],
      tbCustomerId: json['tb_customer_id'],
      nameCustomer: json['name_customer'],
      docCustomer: json['doc_customer'],
      tbSalesmanId: json['tb_salesman_id'],
      nameSalesman: json['name_salesman'],
      docSalesman: json['doc_salesman'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['number'] = number;
    json['tb_customer_id'] = tbCustomerId;
    json['name_customer'] = nameCustomer;
    json['doc_customer'] = docCustomer;
    json['tb_salesman_id'] = tbSalesmanId;
    json['name_salesman'] = nameSalesman;
    json['doc_salesman'] = docSalesman;
    return json;
  }

  factory OrderSaleModel.empty() {
    return OrderSaleModel(
      number: 0,
      tbCustomerId: 0,
      nameCustomer: "",
      docCustomer: "",
      tbSalesmanId: 0,
      nameSalesman: "",
      docSalesman: "",
    );
  }
}
