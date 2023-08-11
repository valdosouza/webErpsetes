class OrderSaleEntity {
  int number;
  int tbCustomerId;
  String nameCustomer;
  String docCustomer;
  int tbSalesmanId;
  String nameSalesman;
  String docSalesman;

  OrderSaleEntity({
    required this.number,
    required this.tbCustomerId,
    required this.nameCustomer,
    required this.docCustomer,
    required this.tbSalesmanId,
    required this.nameSalesman,
    required this.docSalesman,
  });
}
