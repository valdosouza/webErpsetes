// ignore_for_file: public_member_api_docs, sort_constructors_first
class CashierStatementCustomerEntity {
  int tbOrderId;
  int id;
  int tbSalesmanId;
  String dtRecord;
  String nameCustomer;
  String timeAttendace;
  double valuerCharged;
  String note;
  bool expanded;
  CashierStatementCustomerEntity({
    required this.tbOrderId,
    required this.id,
    required this.tbSalesmanId,
    required this.dtRecord,
    required this.nameCustomer,
    required this.timeAttendace,
    required this.valuerCharged,
    required this.note,
    required this.expanded,
  });
}