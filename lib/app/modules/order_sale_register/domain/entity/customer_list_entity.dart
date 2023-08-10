class CustomerListEntity {
  int id;
  String nameCompany;
  String nickTrade;
  String docKind;
  String docNumber;

  String error;
  CustomerListEntity({
    required this.id,
    required this.nameCompany,
    required this.nickTrade,
    required this.docKind,
    required this.docNumber,
    required this.error,
  });
}
