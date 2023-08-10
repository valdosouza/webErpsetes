class OrderSaleListEntity {
  int id;
  int number;
  String dtRecord;
  int tbCustomerId;
  String nameCustomer;
  String docCustomer;
  int tbSalesmanId;
  String nameSalesman;
  String docSalesman;
  String status;
  OrderSaleListEntity(
      {required this.id,
      required this.number,
      required this.dtRecord,
      required this.tbCustomerId,
      required this.nameCustomer,
      required this.docCustomer,
      required this.tbSalesmanId,
      required this.nameSalesman,
      required this.docSalesman,
      required this.status});
}
