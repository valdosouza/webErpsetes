import 'package:appweb/app/core/error/exceptions.dart';
import 'package:appweb/app/core/error/failures.dart';
import 'package:appweb/app/modules/Core/data/model/stock_list_model.dart';
import 'package:appweb/app/modules/Core/domain/usecase/usecase.dart';
import 'package:appweb/app/modules/order_stock_adjust_register/domain/repository/respository.dart';
import 'package:dartz/dartz.dart';

class GetStockList implements UseCase<List<StockListModel>, ParamsStockList> {
  final Repository repository;

  GetStockList({required this.repository});

  @override
  Future<Either<Failure, List<StockListModel>>> call(
      ParamsStockList params) async {
    try {
      final list = await repository.getStockList(params: params);
      return list;
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}

class ParamsStockList {
  int tbInstitutionId;
  int page;
  int? id;
  String? description;
  ParamsStockList({
    required this.tbInstitutionId,
    required this.page,
    this.id,
    this.description,
  });
  Map<dynamic, dynamic> toJson() {
    final Map<dynamic, dynamic> data = <dynamic, dynamic>{};
    data['tb_institution_id'] = tbInstitutionId;
    data['page'] = page;
    data['id'] = id;
    data['description'] = description;

    return data;
  }
}
