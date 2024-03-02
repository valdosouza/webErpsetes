import 'package:appweb/app/modules/Core/domain/entity/order_bonus_entity.dart';

class OrderBonusModel extends OrderBonusEntity {
  OrderBonusModel({
    int? number,
    int? tbCustomerId,
    String? nameCustomer,
    String? docCustomer,
    int? tbSalesmanId,
    String? nameSalesman,
  }) : super(
          number: number ?? 0,
          tbCustomerId: tbCustomerId ?? 0,
          nameCustomer: nameCustomer ?? "",
          docCustomer: docCustomer ?? "",
          tbSalesmanId: tbSalesmanId ?? 0,
          nameSalesman: nameSalesman ?? "",
        );

  factory OrderBonusModel.fromJson(Map<String, dynamic> json) {
    return OrderBonusModel(
      number: json['number'],
      tbCustomerId: json['tb_customer_id'],
      nameCustomer: json['name_customer'],
      docCustomer: json['doc_customer'],
      tbSalesmanId: json['tb_salesman_id'],
      nameSalesman: json['name_salesman'],
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

    return json;
  }

  factory OrderBonusModel.empty() {
    return OrderBonusModel(
      number: 0,
      tbCustomerId: 0,
      nameCustomer: "",
      docCustomer: "",
      tbSalesmanId: 0,
      nameSalesman: "",
    );
  }
}
