import 'package:appweb/app/modules/Core/data/model/order_billing_model.dart';
import 'package:appweb/app/modules/Core/data/model/order_model.dart';
import 'package:appweb/app/modules/Core/data/model/order_sale_item_model.dart';
import 'package:appweb/app/modules/Core/data/model/order_sale_model.dart';
import 'package:appweb/app/modules/Core/data/model/order_totalizer_model.dart';

class OrderSaleMainEntity {
  OrderModel order;
  OrderSaleModel orderSale;
  OrderBillingModel orderBilling;
  OrderTotalizerModel orderTotalizer;
  List<OrderSaleItemModel> items;

  OrderSaleMainEntity({
    required this.order,
    required this.orderSale,
    required this.orderBilling,
    required this.orderTotalizer,
    required this.items,
  });
}
