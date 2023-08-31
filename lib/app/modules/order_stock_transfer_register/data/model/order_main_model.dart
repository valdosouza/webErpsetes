import 'package:appweb/app/modules/Core/data/model/order_model.dart';
import 'package:appweb/app/modules/Core/data/model/order_stock_transfer_item_model.dart';
import 'package:appweb/app/modules/Core/data/model/order_stock_transfer_model.dart';
import 'package:appweb/app/modules/order_stock_transfer_register/domain/entity/order_stock_transfer_main_entity.dart';

class OrderStockTransferMainModel extends OrderStockTransferMainEntity {
  OrderStockTransferMainModel({
    OrderModel? order,
    OrderStockTransferModel? orderStockTransfer,
    List<OrderStockTransferItemModel>? items,
  }) : super(
          order: order ?? OrderModel.empty(),
          orderStockTransfer:
              orderStockTransfer ?? OrderStockTransferModel.empty(),
          items: items ?? [],
        );

  factory OrderStockTransferMainModel.fromJson(Map<String, dynamic> json) =>
      OrderStockTransferMainModel(
        order: OrderModel.fromJson(json["order"]),
        orderStockTransfer:
            OrderStockTransferModel.fromJson(json["stock_transfer"]),
        items: List<OrderStockTransferItemModel>.from(
          json["items"].map(
            (x) => OrderStockTransferItemModel.fromJson(x),
          ),
        ),
      );

  factory OrderStockTransferMainModel.empty() => OrderStockTransferMainModel(
        order: OrderModel.empty(),
        orderStockTransfer: OrderStockTransferModel.empty(),
        items: [],
      );

  Map<String, dynamic> toJson() => {
        "order": order.toJson(),
        "stock_transfer": orderStockTransfer.toJson(),
        "items": items.map((e) => e.toJson()).toList(),
      };
}
