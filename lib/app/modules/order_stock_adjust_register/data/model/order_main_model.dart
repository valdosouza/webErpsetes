import 'package:appweb/app/modules/Core/data/model/order_model.dart';
import 'package:appweb/app/modules/Core/data/model/order_stock_adjust_item_model.dart';
import 'package:appweb/app/modules/Core/data/model/order_stock_adjust_model.dart';
import 'package:appweb/app/modules/order_stock_adjust_register/domain/entity/order_stock_adjust_main_entity.dart';

class OrderStockAdjustMainModel extends OrderStockAdjustMainEntity {
  OrderStockAdjustMainModel({
    OrderModel? order,
    OrderStockAdjustModel? orderStockAdjust,
    List<OrderStockAdjustItemModel>? items,
  }) : super(
          order: order ?? OrderModel.empty(),
          orderStockAdjust: orderStockAdjust ?? OrderStockAdjustModel.empty(),
          items: items ?? [],
        );

  factory OrderStockAdjustMainModel.fromJson(Map<String, dynamic> json) =>
      OrderStockAdjustMainModel(
        order: OrderModel.fromJson(json["order"]),
        orderStockAdjust: OrderStockAdjustModel.fromJson(json["stock_adjust"]),
        items: List<OrderStockAdjustItemModel>.from(
          json["items"].map(
            (x) => OrderStockAdjustItemModel.fromJson(x),
          ),
        ),
      );

  factory OrderStockAdjustMainModel.empty() => OrderStockAdjustMainModel(
        order: OrderModel.empty(),
        orderStockAdjust: OrderStockAdjustModel.empty(),
        items: [],
      );

  Map<String, dynamic> toJson() => {
        "order": order.toJson(),
        "stock_adjust": orderStockAdjust.toJson(),
        "items": items.map((e) => e.toJson()).toList(),
      };
}
