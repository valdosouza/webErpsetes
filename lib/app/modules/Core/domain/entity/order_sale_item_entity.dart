class OrderSaleItemEntity {
  int id;
  int tbOrderId;
  int tbProductId;
  String nameProduct;
  int tbStockListId;
  double quantity;
  double unitValue;
  double discountAliquot;
  double discountValue;
  double subtotal;
  int tbPriceListId;
  String updateStatus;

  OrderSaleItemEntity({
    required this.id,
    required this.tbOrderId,
    required this.tbProductId,
    required this.nameProduct,
    required this.tbStockListId,
    required this.quantity,
    required this.unitValue,
    required this.discountAliquot,
    required this.discountValue,
    required this.subtotal,
    required this.tbPriceListId,
    required this.updateStatus,
  });
}
