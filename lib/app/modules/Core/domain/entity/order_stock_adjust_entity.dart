class OrderStockAdjustEntity {
  int number;
  int tbEntityId;
  String nameEntity;
  String docEntity;
  int tbStockListId;
  String nameStockList;
  String direction;

  OrderStockAdjustEntity({
    required this.number,
    required this.tbEntityId,
    required this.nameEntity,
    required this.docEntity,
    required this.tbStockListId,
    required this.nameStockList,
    required this.direction,
  });
}
