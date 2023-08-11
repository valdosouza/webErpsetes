import 'package:appweb/app/core/error/exceptions.dart';
import 'package:appweb/app/core/error/failures.dart';
import 'package:appweb/app/modules/Core/domain/usecase/usecase.dart';
import 'package:appweb/app/modules/order_sale_register/data/model/order_sale_list_model.dart';
import 'package:appweb/app/modules/order_sale_register/domain/repository/respository.dart';
import 'package:dartz/dartz.dart';

class GetOrderList
    implements UseCase<List<OrderSaleListModel>, ParamsOrderList> {
  final Repository repository;

  GetOrderList({required this.repository});

  @override
  Future<Either<Failure, List<OrderSaleListModel>>> call(
      ParamsOrderList params) async {
    try {
      final list = await repository.getOrderList();
      return list;
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}

class ParamsOrderList {
  int tbInstitutionId;
  int page;
  int? id;
  int tbSalesmanId;
  ParamsOrderList({
    required this.tbInstitutionId,
    required this.page,
    required this.tbSalesmanId,
    this.id,
  });
  Map<dynamic, dynamic> toJson() {
    final Map<dynamic, dynamic> data = <dynamic, dynamic>{};
    data['tb_institution_id'] = tbInstitutionId;
    data['page'] = page;
    data['id'] = id;
    data['tb_salesman_id'] = tbSalesmanId;
    return data;
  }
}
