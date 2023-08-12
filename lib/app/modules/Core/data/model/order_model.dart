import 'package:appweb/app/core/shared/utils/custom_date.dart';
import 'package:appweb/app/modules/Core/domain/entity/order_entity.dart';

class OrderModel extends OrderEntity {
  OrderModel({
    int? id,
    int? tbInstitutionId,
    int? terminal,
    int? tbUserId,
    String? docUser,
    String? dtRecord,
    String? note,
    String? origin,
    String? status,
    String? beingUsed,
  }) : super(
          id: id ?? 0,
          tbInstitutionId: tbInstitutionId ?? 0,
          terminal: terminal ?? 0,
          tbUserId: tbUserId ?? 0,
          docUser: docUser ?? "",
          dtRecord: dtRecord ?? "",
          note: note ?? "",
          origin: origin ?? "",
          status: status ?? "",
          beingUsed: beingUsed ?? "",
        );

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
        id: json['id'],
        tbInstitutionId: json['tb_institution_id'],
        terminal: json['terminal'],
        tbUserId: json['tb_user_id'],
        docUser: json['doc_user'],
        dtRecord: CustomDate.formatDateIn(json['dt_record']),
        note: json['note'],
        origin: json['origin'],
        status: json['status'],
        beingUsed: json['being_used']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['id'] = id;
    json['tb_institution_id'] = tbInstitutionId;
    json['terminal'] = terminal;
    json['tb_user_id'] = tbUserId;
    json['doc_user'] = docUser;
    json['dt_record'] = CustomDate.formatDateOut(dtRecord);
    json['note'] = note;
    json['origin'] = origin;
    json['status'] = status;
    json['being_used'] = beingUsed;
    return json;
  }

  factory OrderModel.empty() {
    return OrderModel(
      id: 0,
      tbInstitutionId: 0,
      terminal: 0,
      tbUserId: 0,
      docUser: "",
      dtRecord: CustomDate.newDate(),
      note: "",
      origin: "",
      status: "A",
      beingUsed: "",
    );
  }
}
