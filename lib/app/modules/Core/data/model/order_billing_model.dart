import 'package:appweb/app/modules/Core/domain/entity/order_billing_entity.dart';

class OrderBillingModel extends OrderBillingEntity {
  OrderBillingModel({
    int? tbPaymentTypesId,
    String? namePayment,
    int? taskOwner,
    String? deadline,
    int? plots,
  }) : super(
          tbPaymentTypesId: tbPaymentTypesId ?? 0,
          namePayment: namePayment ?? '',
          taskOwner: taskOwner ?? 0,
          deadline: deadline ?? '',
          plots: plots ?? 0,
        );

  factory OrderBillingModel.fromJson(Map<String, dynamic> json) {
    return OrderBillingModel(
      tbPaymentTypesId: json['tb_payment_types_id'],
      namePayment: json['name_payment'],
      taskOwner: json['task_owner'],
      deadline: json['deadline'],
      plots: json['plots'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['tb_payment_types_id'] = tbPaymentTypesId;
    json['name_payment'] = namePayment;
    json['task_owner'] = taskOwner;
    json['deadline'] = deadline;
    json['plots'] = plots;
    return json;
  }

  factory OrderBillingModel.empty() {
    return OrderBillingModel(
      tbPaymentTypesId: 0,
      namePayment: "",
      taskOwner: 0,
      deadline: "",
      plots: 0,
    );
  }
}
