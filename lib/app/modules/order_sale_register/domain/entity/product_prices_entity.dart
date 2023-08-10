class ProductPricesEntity {
  int tbInstitutionId;
  int id;
  String nameProduct;
  List<PricesEntity> items;

  ProductPricesEntity({
    required this.tbInstitutionId,
    required this.id,
    required this.nameProduct,
    required this.items,
  });
}

class PricesEntity {
  int id;
  String namePriceList;
  double priceTag;
  PricesEntity({
    required this.id,
    required this.namePriceList,
    required this.priceTag,
  });
}
