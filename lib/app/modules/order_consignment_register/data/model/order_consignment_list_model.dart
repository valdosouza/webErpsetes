import 'package:appweb/app/core/shared/utils/custom_date.dart';
import 'package:appweb/app/modules/order_consignment_register/domain/entity/order_consignment_list.dart';

class OrderConsignmetListModel extends OrderConsignmentListEntity {
  OrderConsignmetListModel({
    required int id,
    required int tbInstitutionId,
    required int tbUserId,
    required int tbCustomerId,
    required String nameEntity,
    required String dtRecord,
    required int number,
    required String status,
    required String note,
  }) : super(
          id: id,
          tbInstitutionId: tbInstitutionId,
          tbUserId: tbUserId,
          tbCustomerId: tbCustomerId,
          nameEntity: nameEntity,
          dtRecord: dtRecord,
          number: number,
          status: status,
          note: note,
        );

  factory OrderConsignmetListModel.fromJson(Map<String, dynamic> json) {
    return OrderConsignmetListModel(
      id: json['id'],
      tbInstitutionId: json['tb_institution_id'],
      tbUserId: json['tb_user_id'],
      tbCustomerId:
          (json['tb_customer_id'] != null) ? json['tb_customer_id'] : 0,
      nameEntity: (json['name_entity'] != null) ? json['name_entity'] : "",
      dtRecord: CustomDate.formatDateIn(json['dt_record']),
      number: (json['number'] != null) ? json['number'] : 0,
      status: (json['status'] != null) ? json['status'] : "",
      note: (json['note'] != null) ? json['noter'] : "",
    );
  }
}
