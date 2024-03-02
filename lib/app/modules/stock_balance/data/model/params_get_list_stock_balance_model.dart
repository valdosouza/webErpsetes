import 'package:appweb/app/modules/stock_balance/domain/entity/params_get_list_stock_balance_entity.dart';

class ParamsGetlistStockBalanceModel extends ParamsGetlistStockBalanceEntity {
  ParamsGetlistStockBalanceModel({
    required super.tbInstitutionId,
    required super.tbSalesmanId,
    required super.tbStockListId,
    required super.page,
    int? id,
    String? nameProduct,
  }) : super(
          id: id ?? 0,
          nameProduct: nameProduct ?? "",
        );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['tb_institution_id'] = tbInstitutionId;
    data['tb_salesman_id'] = tbSalesmanId;
    data['tb_stock_list_id'] = tbStockListId;
    data['page'] = page;
    data['id'] = id;
    data['name_product'] = nameProduct;

    return data;
  }
}
