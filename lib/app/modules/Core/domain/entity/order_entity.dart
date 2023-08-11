class OrderEntity {
  int id;
  int tbInstitutionId;
  int terminal;
  int tbUserId;
  String docUser;
  String dtRecord;
  String note;
  String origin;
  String status;
  String beingUsed;

  OrderEntity({
    required this.id,
    required this.tbInstitutionId,
    required this.terminal,
    required this.tbUserId,
    required this.docUser,
    required this.dtRecord,
    required this.note,
    required this.origin,
    required this.status,
    required this.beingUsed,
  });
}
