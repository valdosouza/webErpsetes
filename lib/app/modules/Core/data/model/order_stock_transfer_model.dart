import 'package:appweb/app/modules/Core/domain/entity/order_stock_transfer_entity.dart';

class OrderStockTransferModel extends OrderStockTransferEntity {
  OrderStockTransferModel({
    int? number,
    int? tbEntityId,
    String? nameEntity,
    String? docEntity,
  }) : super(
          number: number ?? 0,
          tbEntityId: tbEntityId ?? 0,
          nameEntity: nameEntity ?? "",
          docEntity: docEntity ?? "",
        );

  factory OrderStockTransferModel.fromJson(Map<String, dynamic> json) {
    return OrderStockTransferModel(
      number: json['number'],
      tbEntityId: json['tb_entity_id'],
      nameEntity: json['name_entity'],
      docEntity: json['doc_entity'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['number'] = number;
    json['tb_entity_id'] = tbEntityId;
    json['name_entity'] = nameEntity;
    json['doc_entity'] = docEntity;

    return json;
  }

  factory OrderStockTransferModel.empty() {
    return OrderStockTransferModel(
      number: 0,
      tbEntityId: 0,
      nameEntity: "",
      docEntity: "",
    );
  }
}
