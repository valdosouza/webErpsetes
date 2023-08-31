class ItemsEntity {
  int id;
  int tbProductId;
  String nameProduct;
  double quantity;
  double unitValue;
  String updateStatus;
  ItemsEntity({
    required this.id,
    required this.tbProductId,
    required this.nameProduct,
    required this.quantity,
    required this.unitValue,
    required this.updateStatus,
  });
}
