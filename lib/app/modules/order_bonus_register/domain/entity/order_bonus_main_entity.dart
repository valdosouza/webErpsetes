import 'package:appweb/app/modules/Core/data/model/order_model.dart';
import 'package:appweb/app/modules/Core/data/model/order_bonus_item_model.dart';
import 'package:appweb/app/modules/Core/data/model/order_bonus_model.dart';

class OrderBonusMainEntity {
  OrderModel order;
  OrderBonusModel orderBonus;
  List<OrderBonusItemModel> items;

  OrderBonusMainEntity({
    required this.order,
    required this.orderBonus,
    required this.items,
  });
}
