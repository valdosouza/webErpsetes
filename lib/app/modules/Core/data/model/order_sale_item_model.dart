import 'package:appweb/app/modules/Core/domain/entity/order_sale_item_entity.dart';

class OrderSaleItemModel extends OrderSaleItemEntity {
  OrderSaleItemModel({
    int? id,
    int? tbOrderId,
    int? tbProductId,
    String? nameProduct,
    int? tbStockListId,
    double? quantity,
    double? unitValue,
    double? discountAliquot,
    double? discountValue,
    double? subtotal,
    int? tbPriceListId,
    String? updateStatus,
  }) : super(
          id: id ?? 0,
          tbOrderId: tbOrderId ?? 0,
          tbProductId: tbProductId ?? 0,
          nameProduct: nameProduct ?? "",
          tbStockListId: tbStockListId ?? 0,
          quantity: quantity ?? 0.0,
          unitValue: unitValue ?? 0.0,
          discountAliquot: discountAliquot ?? 0.0,
          discountValue: discountValue ?? 0.0,
          subtotal: subtotal ?? 0.00,
          tbPriceListId: tbPriceListId ?? 0,
          updateStatus: updateStatus ?? "",
        );

  factory OrderSaleItemModel.fromJson(Map<String, dynamic> json) {
    double lcQuantity = json['quantity'] is int
        ? json['quantity'].toDouble()
        : json['quantity'];
    double lcUnitValue = json['unit_value'] is int
        ? json['unit_value'].toDouble()
        : json['unit_value'];
    double lcDiscountAliquot = json['discount_aliquot'] is int
        ? json['discount_aliquot'].toDouble()
        : json['discount_aliquot'];
    double lcDiscountValue = json['discount_value'] is int
        ? json['discount_value'].toDouble()
        : json['discount_value'];
    return OrderSaleItemModel(
      id: json['id'],
      tbOrderId: json['tb_order_id'],
      tbProductId: json['tb_product_id'],
      nameProduct: json['name_product'],
      tbStockListId: json['tb_stock_list_id'],
      quantity: lcQuantity,
      unitValue: lcUnitValue,
      discountAliquot: lcDiscountAliquot,
      discountValue: lcDiscountValue,
      subtotal: (lcQuantity * lcUnitValue) - lcDiscountValue,
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
    data['quantity'] = quantity;
    data['unit_value'] = unitValue;
    data['discount_aliquot'] = discountAliquot;
    data['discount_value'] = discountValue;
    data['update_status'] = updateStatus;
    return data;
  }

  factory OrderSaleItemModel.empty() {
    return OrderSaleItemModel();
  }
}
