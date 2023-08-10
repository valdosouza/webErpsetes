import 'package:appweb/app/modules/order_sale_register/domain/entity/product_prices_entity.dart';

class ProductPricesModel extends ProductPricesEntity {
  ProductPricesModel({
    int? tbInstitutionId,
    int? id,
    String? nameProduct,
    List<PricesEntity>? items,
  }) : super(
          tbInstitutionId: tbInstitutionId ?? 0,
          id: id ?? 0,
          nameProduct: nameProduct ?? "",
          items: items ?? [],
        );

  factory ProductPricesModel.fromJson(Map<String, dynamic> json) {
    return ProductPricesModel(
      tbInstitutionId: json['tb_institution_id'] as int? ?? 0,
      id: json['id'] as int? ?? 0,
      nameProduct: json['name_product'] as String? ?? "",
      items: List<PricesModel>.from(
        json["items"].map(
          (x) => PricesModel.fromJson(x),
        ),
      ),
    );
  }

  factory ProductPricesModel.empty() {
    return ProductPricesModel(
      tbInstitutionId: 0,
      id: 0,
      nameProduct: "",
      items: [],
    );
  }
}

class PricesModel extends PricesEntity {
  PricesModel({
    int? id,
    String? namePriceList,
    double? priceTag,
  }) : super(
            id: id ?? 0,
            namePriceList: namePriceList ?? "",
            priceTag: priceTag ?? 0.0);

  factory PricesModel.fromJson(Map<String, dynamic> json) {
    return PricesModel(
      id: json['id'] as int? ?? 0,
      namePriceList: json['name_price_list'] as String? ?? "",
      priceTag: json['price_tag'] is int
          ? json['price_tag'].toDouble()
          : json['price_tag'],
    );
  }
}
