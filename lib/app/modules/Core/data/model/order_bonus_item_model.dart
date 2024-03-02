import 'package:appweb/app/modules/Core/domain/entity/order_bonus_item_entity.dart';

class OrderBonusItemModel extends OrderBonusItemEntity {
  OrderBonusItemModel({
    int? id,
    int? tbOrderId,
    int? tbProductId,
    String? nameProduct,
    int? tbStockListId,
    String? nameStockList,
    double? quantity,
    double? unitValue,
    String? updateStatus,
  }) : super(
          id: id ?? 0,
          tbOrderId: tbOrderId ?? 0,
          tbProductId: tbProductId ?? 0,
          nameProduct: nameProduct ?? "",
          tbStockListId: tbStockListId ?? 0,
          nameStockList: nameStockList ?? "",
          quantity: quantity ?? 0.0,
          unitValue: unitValue ?? 0.0,
          updateStatus: updateStatus ?? "",
        );

  factory OrderBonusItemModel.fromJson(Map<String, dynamic> json) {
    return OrderBonusItemModel(
      id: json['id'],
      tbOrderId: json['tb_order_id'],
      tbProductId: json['tb_product_id'],
      nameProduct: json['name_product'],
      tbStockListId: json['tb_stock_list_id'],
      nameStockList: json['name_stock_list'],
      quantity: json['quantity'] is int
          ? json['quantity'].toDouble()
          : json['quantity'],
      unitValue: json['unit_value'] is int
          ? json['unit_value'].toDouble()
          : json['unit_value'],
      updateStatus: json['update_status'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['tb_order_id'] = tbOrderId;
    data['tb_product_id'] = tbProductId;
    data['name_product'] = nameProduct;
    data['tb_stock_list_id'] = tbStockListId;
    data['name_stock_list'] = nameStockList;
    data['quantity'] = quantity;
    data['unit_value'] = unitValue;
    data['update_status'] = updateStatus;
    return data;
  }

  factory OrderBonusItemModel.empty() {
    return OrderBonusItemModel();
  }
}
