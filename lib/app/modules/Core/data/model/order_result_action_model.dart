import 'package:appweb/app/modules/Core/domain/entity/order_result_action_entity.dart';

class OrderResultActionModel extends OrderResultActionEntity {
  OrderResultActionModel({
    bool? result,
    String? message,
  }) : super(
          result: result ?? false,
          message: message ?? "",
        );

  factory OrderResultActionModel.fromJson(Map<String, dynamic> json) {
    return OrderResultActionModel(
      result: json['result'],
      message: json['message'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['result'] = result;
    json['message'] = message;

    return json;
  }

  factory OrderResultActionModel.empty() {
    return OrderResultActionModel(
      result: false,
      message: "",
    );
  }
}
