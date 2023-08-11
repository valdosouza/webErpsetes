import 'package:appweb/app/modules/order_stock_adjustment_register/data/model/order_stock_adjustment_register_items_model.dart';
import 'package:appweb/app/modules/order_stock_adjustment_register/data/model/order_stock_adjustment_register_model.dart';

class OrderStockAdjustmentMainModel {
  late OrderStockAdjustmentRegisterModel order =
      OrderStockAdjustmentRegisterModel.empty();
  late List<OrderStockAdjustmentRegisterItemsModel> items = [];

  OrderStockAdjustmentMainModel({
    required this.order,
    required this.items,
  });

  factory OrderStockAdjustmentMainModel.fromJson(Map<String, dynamic> json) =>
      OrderStockAdjustmentMainModel(
        order: OrderStockAdjustmentRegisterModel.fromJson(json["order"]),
        items: json["items"] != null
            ? List<OrderStockAdjustmentRegisterItemsModel>.from(
                json["items"].map(
                  (x) => OrderStockAdjustmentRegisterItemsModel.fromJson(x),
                ),
              )
            : [],
      );

  factory OrderStockAdjustmentMainModel.empty() =>
      OrderStockAdjustmentMainModel(
        order: OrderStockAdjustmentRegisterModel.empty(),
        items: [],
      );

  Map<String, dynamic> toJson() => {
        "order": order.toJson(),
        "items": items.map((e) => e.toJson()).toList(),
      };
}
