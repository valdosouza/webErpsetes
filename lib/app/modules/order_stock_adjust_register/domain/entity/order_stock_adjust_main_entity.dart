import 'package:appweb/app/modules/Core/data/model/order_model.dart';
import 'package:appweb/app/modules/Core/data/model/order_stock_adjust_item_model.dart';
import 'package:appweb/app/modules/Core/data/model/order_stock_adjust_model.dart';

class OrderStockAdjustMainEntity {
  OrderModel order;
  OrderStockAdjustModel orderStockAdjust;
  List<OrderStockAdjustItemModel> items;

  OrderStockAdjustMainEntity({
    required this.order,
    required this.orderStockAdjust,
    required this.items,
  });
}
