class OrderBonusItemEntity {
  int id;
  int tbOrderId;
  int tbProductId;
  String nameProduct;
  int tbStockListId;
  String nameStockList;
  double quantity;
  double unitValue;
  String updateStatus;

  OrderBonusItemEntity({
    required this.id,
    required this.tbOrderId,
    required this.tbProductId,
    required this.nameProduct,
    required this.tbStockListId,
    required this.nameStockList,
    required this.quantity,
    required this.unitValue,
    required this.updateStatus,
  });
}
