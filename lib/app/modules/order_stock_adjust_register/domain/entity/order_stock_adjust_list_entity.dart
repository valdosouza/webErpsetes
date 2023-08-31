class OrderStockAdjustListEntity {
  int id;
  int tbUserId;
  int tbEntityId;
  String nameEntity;
  int number;
  String dtRecord;
  String status;

  OrderStockAdjustListEntity({
    required this.id,
    required this.tbUserId,
    required this.tbEntityId,
    required this.nameEntity,
    required this.number,
    required this.dtRecord,
    required this.status,
  });
}
