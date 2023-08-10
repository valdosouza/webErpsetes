import 'package:appweb/app/core/shared/utils/custom_date.dart';
import 'package:appweb/app/modules/order_sale_register/data/model/items_model.dart';
import 'package:appweb/app/modules/order_sale_register/domain/entity/order_entity.dart';

class OrderModel extends OrderEntity {
  OrderModel({
    int? id,
    int? tbInstitutionId,
    int? tbUserId,
    int? tbCustomerId,
    String? nameCustomer,
    int? number,
    String? dtRecord,
    int? tbPaymentTypesId,
    String? namePaymentTypes,
    int? plots,
    String? deadline,
    int? tbStockListId,
    String? nameStockList,
    String? note,
    String? status,
    List<ItemsModel>? items,
  }) : super(
          id: id ?? 0,
          tbInstitutionId: tbInstitutionId ?? 0,
          tbUserId: tbUserId ?? 0,
          tbCustomerId: tbCustomerId ?? 0,
          nameCustomer: nameCustomer ?? "",
          number: number ?? 0,
          dtRecord: dtRecord ?? "",
          tbPaymentTypesId: tbPaymentTypesId ?? 0,
          namePaymentTypes: namePaymentTypes ?? "",
          plots: plots ?? 0,
          deadline: deadline ?? "",
          tbStockListId: tbStockListId ?? 0,
          nameStockList: nameStockList ?? "",
          note: note ?? "",
          status: status ?? "",
          items: items ?? List<ItemsModel>.empty(growable: true),
        );

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
        id: json['id'] is String ? int.parse(json['id']) : json['id'],
        tbInstitutionId: json['tb_institution_id'] is String
            ? int.parse(json['tb_institution_id'])
            : json['tb_institution_id'],
        tbUserId: json['tb_user_id'] is String
            ? int.parse(json['tb_user_id'])
            : json['tb_user_id'],
        tbCustomerId: json['tb_customer_id'] is String
            ? int.parse(json['tb_customer_id'])
            : json['tb_customer_id'],
        nameCustomer: json['name_customer'] as String? ?? "",
        number: json['number'] is String
            ? int.parse(json['number'])
            : json['number'],
        dtRecord: CustomDate.formatDateIn(json['dt_record']),
        tbPaymentTypesId: json['tb_payment_types_id'] is String
            ? int.parse(json['tb_payment_types_id'])
            : json['tb_payment_types_id'],
        namePaymentTypes: json['name_payment_types'] as String? ?? "",
        note: json['note'] as String? ?? "",
        tbStockListId: json['tb_stock_list_id'] is String
            ? int.parse(json['tb_stock_list_id'])
            : json['tb_stock_list_id'],
        nameStockList: json['name_stock_list'] as String? ?? "",
        status: json['status'] as String? ?? "",
        items: json['items'] == null
            ? null
            : (json['items'] as List)
                .map((e) => ItemsModel.fromJson(e))
                .toList());
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['tb_institution_id'] = tbInstitutionId;
    data['tb_user_id'] = tbUserId;
    data['tb_customer_id'] = tbCustomerId;
    data['name_customer'] = nameCustomer;
    data['number'] = number;
    data['dt_record'] = CustomDate.formatDateOut(dtRecord);
    data['tb_stock_list_id'] = tbStockListId;
    data['name_stock_list'] = nameStockList;
    data['note'] = note;
    data['status'] = status;
    return data;
  }

  factory OrderModel.empty() {
    return OrderModel(
      dtRecord: CustomDate.newDate(),
      status: "A",
    );
  }
}
