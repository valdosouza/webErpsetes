import 'package:appweb/app/modules/Core/domain/entity/customer_list_entity.dart';

class CustomerListModel extends CustomerListEntity {
  CustomerListModel({
    int? id,
    String? nameCompany,
    String? nickTrade,
    String? docKind,
    String? docNumber,
    String? error,
  }) : super(
          id: id ?? 0,
          nameCompany: nameCompany ?? "",
          nickTrade: nickTrade ?? "",
          docKind: docKind ?? "",
          docNumber: docNumber ?? "",
          error: error ?? "",
        );

  factory CustomerListModel.fromJson(Map<String, dynamic> json) {
    return CustomerListModel(
        id: json['id'] as int? ?? 0,
        nameCompany: json['name_company'] as String? ?? "",
        nickTrade: json['nick_trade'] as String? ?? "",
        docKind: json['doc_kind'] as String? ?? "",
        docNumber: json['doc_number'] as String? ?? "",
        error: json['error'] as String? ?? "");
  }
}
