class OrderBillingEntity {
  int tbPaymentTypesId;
  String namePayment;
  int taskOwner;
  String deadline;
  int plots;

  OrderBillingEntity({
    required this.tbPaymentTypesId,
    required this.namePayment,
    required this.taskOwner,
    required this.deadline,
    required this.plots,
  });
}
