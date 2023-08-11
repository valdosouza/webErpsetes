class OrderTotalizerEntity {
  double itemsQtde;
  double productQtde;
  double productValue;
  double ipiValue;
  double discountAliquot;
  double discountValue;
  double expensesValue;
  double totalValue;

  OrderTotalizerEntity({
    required this.itemsQtde,
    required this.productQtde,
    required this.productValue,
    required this.ipiValue,
    required this.discountAliquot,
    required this.discountValue,
    required this.expensesValue,
    required this.totalValue,
  });
}
