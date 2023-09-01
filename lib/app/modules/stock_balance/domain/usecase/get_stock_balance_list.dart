import 'package:appweb/app/core/error/exceptions.dart';
import 'package:appweb/app/core/error/failures.dart';
import 'package:appweb/app/modules/Core/data/model/stock_balance_model.dart';
import 'package:appweb/app/modules/Core/domain/usecase/usecase.dart';
import 'package:appweb/app/modules/stock_balance/domain/repository/repository.dart';
import 'package:dartz/dartz.dart';

class GetStockBalanceList
    implements UseCase<List<StockBalanceItemsModel>, ParamsStockBalanceList> {
  final Repository repository;

  GetStockBalanceList({required this.repository});

  @override
  Future<Either<Failure, List<StockBalanceItemsModel>>> call(
      ParamsStockBalanceList params) async {
    try {
      final list = await repository.getStockBalanceList(params: params);
      return list;
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}

class ParamsStockBalanceList {
  int tbInstitutionId;
  int page;
  int? id;
  int? tbSalesmanId;
  int? tbStockListId;
  String? nameMerchandise;
  ParamsStockBalanceList({
    required this.tbInstitutionId,
    required this.page,
    this.id,
    this.tbSalesmanId,
    this.tbStockListId,
    this.nameMerchandise,
  });
  Map<dynamic, dynamic> toJson() {
    final Map<dynamic, dynamic> data = <dynamic, dynamic>{};
    data['tb_institution_id'] = tbInstitutionId;
    data['page'] = page;
    data['id'] = id;
    data['tb_salemsan_id'] = tbSalesmanId;
    data['tb_stock_list_id'] = tbStockListId;
    data['name_merchandise'] = nameMerchandise;
    return data;
  }
}
