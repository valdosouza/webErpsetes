import 'package:appweb/app/core/shared/utils/custom_date.dart';
import 'package:appweb/app/modules/order_bonus_register/domain/entity/order_bonus_list_entity.dart';

class OrderBonusListModel extends OrderBonusListEntity {
  OrderBonusListModel({
    int? id,
    int? tbUserId,
    int? tbCustomerId,
    String? nameCustomer,
    int? number,
    String? dtRecord,
    String? status,
  }) : super(
          id: id ?? 0,
          tbUserId: tbUserId ?? 0,
          tbCustomerId: tbCustomerId ?? 0,
          nameCustomer: nameCustomer ?? "",
          number: number ?? 0,
          dtRecord: dtRecord ?? "",
          status: status ?? "",
        );

  factory OrderBonusListModel.fromJson(Map<String, dynamic> json) {
    return OrderBonusListModel(
      id: json['id'],
      tbUserId: json['tb_user_id'],
      tbCustomerId: json['tb_entity_id'],
      nameCustomer: json['name_customer'] as String? ?? "",
      number: json['number'],
      dtRecord: CustomDate.formatDateIn(json['dt_record']),
      status: json['status'] as String? ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['tb_user_id'] = tbUserId;
    data['tb_entity_id'] = tbCustomerId;
    data['name_entity'] = nameCustomer;
    data['number'] = number;
    data['dt_record'] = CustomDate.formatDateOut(dtRecord);
    data['status'] = status;
    return {"order": data};
  }

  factory OrderBonusListModel.empty() {
    return OrderBonusListModel();
  }
}
