class OrderStockTransferItemEntity {
  int id;
  int tbOrderId;
  int tbProductId;
  String nameProduct;
  int tbStockListId;
  double quantity;
  double unitValue;
  String updateStatus;

  OrderStockTransferItemEntity({
    required this.id,
    required this.tbOrderId,
    required this.tbProductId,
    required this.nameProduct,
    required this.tbStockListId,
    required this.quantity,
    required this.unitValue,
    required this.updateStatus,
  });
}
