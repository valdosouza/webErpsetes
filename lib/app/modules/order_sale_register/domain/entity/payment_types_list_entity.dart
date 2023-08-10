class PaymentTypeListEntity {
  int id;
  int tbIinstitutionId;
  String description;
  String active;

  PaymentTypeListEntity({
    required this.id,
    required this.tbIinstitutionId,
    required this.description,
    required this.active,
  });
}
