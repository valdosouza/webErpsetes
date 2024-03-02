import 'package:appweb/app/modules/Core/data/model/order_model.dart';
import 'package:appweb/app/modules/Core/data/model/order_bonus_item_model.dart';
import 'package:appweb/app/modules/Core/data/model/order_bonus_model.dart';
import 'package:appweb/app/modules/order_bonus_register/domain/entity/order_bonus_main_entity.dart';

class OrderBonusMainModel extends OrderBonusMainEntity {
  OrderBonusMainModel({
    OrderModel? order,
    OrderBonusModel? orderBonus,
    List<OrderBonusItemModel>? items,
  }) : super(
          order: order ?? OrderModel.empty(),
          orderBonus: orderBonus ?? OrderBonusModel.empty(),
          items: items ?? [],
        );

  factory OrderBonusMainModel.fromJson(Map<String, dynamic> json) =>
      OrderBonusMainModel(
        order: OrderModel.fromJson(json["order"]),
        orderBonus: OrderBonusModel.fromJson(json["bonus"]),
        items: List<OrderBonusItemModel>.from(
          json["items"].map(
            (x) => OrderBonusItemModel.fromJson(x),
          ),
        ),
      );

  factory OrderBonusMainModel.empty() => OrderBonusMainModel(
        order: OrderModel.empty(),
        orderBonus: OrderBonusModel.empty(),
        items: [],
      );

  Map<String, dynamic> toJson() => {
        "order": order.toJson(),
        "bonus": orderBonus.toJson(),
        "items": items.map((e) => e.toJson()).toList(),
      };
}
