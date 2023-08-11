import 'package:appweb/app/modules/Core/domain/entity/order_totalizer_entity.dart';

class OrderTotalizerModel extends OrderTotalizerEntity {
  OrderTotalizerModel({
    double? itemsQtde,
    double? productQtde,
    double? productValue,
    double? ipiValue,
    double? discountAliquot,
    double? discountValue,
    double? expensesValue,
    double? totalValue,
  }) : super(
          itemsQtde: itemsQtde ?? 0.0,
          productQtde: productQtde ?? 0.0,
          productValue: productValue ?? 0.0,
          ipiValue: ipiValue ?? 0.0,
          discountAliquot: discountAliquot ?? 0.0,
          discountValue: discountValue ?? 0.0,
          expensesValue: expensesValue ?? 0.0,
          totalValue: totalValue ?? 0.0,
        );

  factory OrderTotalizerModel.fromJson(Map<String, dynamic> json) {
    return OrderTotalizerModel(
      itemsQtde: json['items_qtde'] is int
          ? json['items_qtde'].toDouble()
          : json['items_qtde'],
      productQtde: json['product_qtde'] is int
          ? json['product_qtde'].toDouble()
          : json['product_qtde'],
      productValue: json['product_value'] is int
          ? json['product_value'].toDouble()
          : json['product_value'],
      ipiValue: json['ipi_value'] is int
          ? json['ipi_value'].toDouble()
          : json['ipi_value'],
      discountAliquot: json['discount_aliquot'] is int
          ? json['discount_aliquot'].toDouble()
          : json['discount_aliquot'],
      discountValue: json['discount_value'] is int
          ? json['discount_value'].toDouble()
          : json['discount_value'],
      expensesValue: json['expenses_value'] is int
          ? json['expenses_value'].toDouble()
          : json['expenses_value'],
      totalValue: json['total_value'] is int
          ? json['total_value'].toDouble()
          : json['total_value'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['items_qtde'] = itemsQtde;
    json['product_qtde'] = productQtde;
    json['product_value'] = productValue;
    json['ipi_value'] = ipiValue;
    json['discount_aliquot'] = discountAliquot;
    json['discount_value'] = discountValue;
    json['expenses_value'] = expensesValue;
    json['total_value'] = totalValue;
    return json;
  }

  factory OrderTotalizerModel.empty() {
    return OrderTotalizerModel(
      itemsQtde: 0,
      productQtde: 0,
      productValue: 0,
      ipiValue: 0,
      discountAliquot: 0,
      discountValue: 0,
      expensesValue: 0,
      totalValue: 0,
    );
  }
}
