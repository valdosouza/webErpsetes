class CustomerEntity {
  int id;
  int tbInstitutionId;
  int tbSalesmanId;
  int tbCarrierId;
  String creditStatus;
  double creditValue;
  String wallet;
  String consumer;
  double multiplier;
  String active;

  CustomerEntity({
    this.id = 0,
    this.tbInstitutionId = 0,
    this.tbSalesmanId = 0,
    this.tbCarrierId = 0,
    this.creditStatus = "",
    this.creditValue = 0,
    this.wallet = "",
    this.consumer = "",
    this.multiplier = 0,
    this.active = "",
  });
}
