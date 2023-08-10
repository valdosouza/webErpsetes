import 'package:appweb/app/modules/order_sale_register/data/model/items_model.dart';
import 'package:appweb/app/modules/order_sale_register/data/model/order_model.dart';

class OrderMainModel {
  late OrderModel order = OrderModel.empty();
  late List<ItemsModel> items = [];

  OrderMainModel({
    required this.order,
    required this.items,
  });

  factory OrderMainModel.fromJson(Map<String, dynamic> json) => OrderMainModel(
        order: OrderModel.fromJson(json["Order"]),
        items: List<ItemsModel>.from(
          json["Items"].map(
            (x) => ItemsModel.fromJson(x),
          ),
        ),
      );

  factory OrderMainModel.empty() => OrderMainModel(
        order: OrderModel.empty(),
        items: [],
      );

  Map<String, dynamic> toJson() => {
        "Order": order.toJson(),
        "Items": items.map((e) => e.toJson()).toList(),
      };
}
