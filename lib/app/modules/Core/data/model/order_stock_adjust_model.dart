import 'package:appweb/app/modules/Core/domain/entity/order_stock_adjust_entity.dart';

class OrderStockAdjustModel extends OrderStockAdjustEntity {
  OrderStockAdjustModel({
    int? number,
    int? tbEntityId,
    String? nameEntity,
    String? docEntity,
    int? tbStockListId,
    String? nameStockList,
    String? direction,
  }) : super(
          number: number ?? 0,
          tbEntityId: tbEntityId ?? 0,
          nameEntity: nameEntity ?? "",
          docEntity: docEntity ?? "",
          tbStockListId: tbStockListId ?? 0,
          nameStockList: nameStockList ?? "",
          direction: direction ?? "S",
        );

  factory OrderStockAdjustModel.fromJson(Map<String, dynamic> json) {
    return OrderStockAdjustModel(
      number: json['number'],
      tbEntityId: json['tb_entity_id'],
      nameEntity: json['name_entity'],
      docEntity: json['doc_entity'],
      tbStockListId: json['tb_stock_list_id'],
      nameStockList: json['name_stock_list'],
      direction: json['direction'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['number'] = number;
    json['tb_entity_id'] = tbEntityId;
    json['name_entity'] = nameEntity;
    json['doc_entity'] = docEntity;
    json['tb_stock_list_id'] = tbStockListId;
    json['name_stock_list'] = nameStockList;
    json['direction'] = direction;

    return json;
  }

  factory OrderStockAdjustModel.empty() {
    return OrderStockAdjustModel(
      number: 0,
      tbEntityId: 0,
      nameEntity: "",
      docEntity: "",
    );
  }
}
