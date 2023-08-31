import 'package:appweb/app/modules/order_stock_adjust_register/domain/entity/entity_list_entity.dart';

class EntityListModel extends EntityListEntity {
  EntityListModel({
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

  factory EntityListModel.fromJson(Map<String, dynamic> json) {
    return EntityListModel(
      id: json['id'] as int? ?? 0,
      nameCompany: json['name_company'] as String? ?? "",
      nickTrade: json['nick_trade'] as String? ?? "",
      docKind: json['doc_kind'] as String? ?? "",
      docNumber: json['doc_number'] as String? ?? "",
    );
  }
}
