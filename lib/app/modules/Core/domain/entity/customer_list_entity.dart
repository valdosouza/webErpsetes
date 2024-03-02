class CustomerListEntity {
  int id;
  String nameCompany;
  String nickTrade;
  String docKind;
  String docNumber;
  String error;
  String street;
  String nmbr;
  String complement;
  String neighborhood;
  bool expanded = false;

  CustomerListEntity({
    this.id = 0,
    this.nameCompany = "",
    this.nickTrade = "",
    this.docKind = "",
    this.docNumber = "",
    this.error = "",
    this.street = "",
    this.nmbr = "",
    this.neighborhood = "",
    this.complement = "",
    this.expanded = false,
  });
}
