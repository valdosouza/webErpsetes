import 'package:appweb/app/modules/order_sale_register/domain/entity/payment_types_list_entity.dart';

class PaymentTypesListModel extends PaymentTypeListEntity {
  PaymentTypesListModel({
    int? id,
    int? tbInstitutionId,
    String? description,
    String? active,
  }) : super(
          id: id ?? 0,
          tbIinstitutionId: tbInstitutionId ?? 0,
          description: description ?? "",
          active: active ?? "",
        );

  factory PaymentTypesListModel.fromJson(Map<String, dynamic> json) {
    return PaymentTypesListModel(
      id: json['id'] as int? ?? 0,
      tbInstitutionId: json['tb_institution_id'] as int? ?? 0,
      description: json['description'] as String? ?? "",
      active: json['active'] as String? ?? "",
    );
  }
}
