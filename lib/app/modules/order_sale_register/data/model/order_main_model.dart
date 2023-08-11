import 'package:appweb/app/modules/Core/data/model/order_billing_model.dart';
import 'package:appweb/app/modules/Core/data/model/order_model.dart';
import 'package:appweb/app/modules/Core/data/model/order_sale_item_model.dart';
import 'package:appweb/app/modules/Core/data/model/order_sale_model.dart';
import 'package:appweb/app/modules/Core/data/model/order_totalizer_model.dart';
import 'package:appweb/app/modules/order_sale_register/domain/entity/order_sale_main_entity.dart';

class OrderSaleMainModel extends OrderSaleMainEntity {
  OrderSaleMainModel({
    OrderModel? order,
    OrderSaleModel? orderSale,
    OrderBillingModel? orderBilling,
    OrderTotalizerModel? orderTotalizer,
    List<OrderSaleItemModel>? items,
  }) : super(
          order: order ?? OrderModel.empty(),
          orderSale: orderSale ?? OrderSaleModel.empty(),
          orderBilling: orderBilling ?? OrderBillingModel.empty(),
          orderTotalizer: orderTotalizer ?? OrderTotalizerModel.empty(),
          items: items ?? [],
        );

  factory OrderSaleMainModel.fromJson(Map<String, dynamic> json) =>
      OrderSaleMainModel(
        order: OrderModel.fromJson(json["order"]),
        orderSale: OrderSaleModel.fromJson(json["sale"]),
        orderBilling: OrderBillingModel.fromJson(json["billing"]),
        orderTotalizer: OrderTotalizerModel.fromJson(json["totalizer"]),
        items: List<OrderSaleItemModel>.from(
          json["items"].map(
            (x) => OrderSaleItemModel.fromJson(x),
          ),
        ),
      );

  factory OrderSaleMainModel.empty() => OrderSaleMainModel(
        order: OrderModel.empty(),
        orderSale: OrderSaleModel.empty(),
        orderBilling: OrderBillingModel.empty(),
        orderTotalizer: OrderTotalizerModel.empty(),
        items: [],
      );

  Map<String, dynamic> toJson() => {
        "order": order.toJson(),
        "sale": orderSale.toJson(),
        "billing": orderBilling.toJson(),
        "totalizer": orderTotalizer.toJson(),
        "items": items.map((e) => e.toJson()).toList(),
      };
}
