import 'package:appweb/app/modules/Core/data/model/order_model.dart';
import 'package:appweb/app/modules/Core/data/model/order_stock_transfer_item_model.dart';
import 'package:appweb/app/modules/Core/data/model/order_stock_transfer_model.dart';

class OrderStockTransferMainEntity {
  OrderModel order;
  OrderStockTransferModel orderStockTransfer;
  List<OrderStockTransferItemModel> items;

  OrderStockTransferMainEntity({
    required this.order,
    required this.orderStockTransfer,
    required this.items,
  });
}
