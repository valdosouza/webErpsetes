class OrderBonusListEntity {
  int id;
  int tbUserId;
  int tbCustomerId;
  String nameCustomer;
  int number;
  String dtRecord;
  String status;

  OrderBonusListEntity({
    required this.id,
    required this.tbUserId,
    required this.tbCustomerId,
    required this.nameCustomer,
    required this.number,
    required this.dtRecord,
    required this.status,
  });
}
