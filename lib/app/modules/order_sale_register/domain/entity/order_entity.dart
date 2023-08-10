import 'package:appweb/app/modules/order_sale_register/data/model/items_model.dart';

class OrderEntity {
  int id;
  int tbInstitutionId;
  int tbUserId;
  int tbCustomerId;
  String nameCustomer;
  int number;
  String dtRecord;
  int tbPaymentTypesId;
  String namePaymentTypes;
  int plots;
  String deadline;
  int tbStockListId;
  String nameStockList;
  String note;
  String status;
  List<ItemsModel> items;

  OrderEntity({
    required this.id,
    required this.tbInstitutionId,
    required this.tbUserId,
    required this.tbCustomerId,
    required this.nameCustomer,
    required this.number,
    required this.dtRecord,
    required this.tbPaymentTypesId,
    required this.namePaymentTypes,
    required this.plots,
    required this.deadline,
    required this.tbStockListId,
    required this.nameStockList,
    required this.note,
    required this.status,
    required this.items,
  });
}
