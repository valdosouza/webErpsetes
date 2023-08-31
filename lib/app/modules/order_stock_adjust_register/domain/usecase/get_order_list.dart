import 'package:appweb/app/core/error/exceptions.dart';
import 'package:appweb/app/core/error/failures.dart';
import 'package:appweb/app/modules/Core/domain/usecase/usecase.dart';
import 'package:appweb/app/modules/order_stock_adjust_register/data/model/order_stock_adjust_list_model.dart';
import 'package:appweb/app/modules/order_stock_adjust_register/domain/repository/respository.dart';
import 'package:dartz/dartz.dart';

class GetOrderList
    implements UseCase<List<OrderStockAdjustListModel>, ParamsOrderList> {
  final Repository repository;

  GetOrderList({required this.repository});

  @override
  Future<Either<Failure, List<OrderStockAdjustListModel>>> call(
      ParamsOrderList params) async {
    try {
      final list = await repository.getOrderList(params: params);
      return list;
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}

class ParamsOrderList {
  int tbInstitutionId;
  int page;
  int number;
  int tbUserId;
  String nickTrade;
  ParamsOrderList({
    required this.tbInstitutionId,
    required this.page,
    required this.tbUserId,
    required this.number,
    required this.nickTrade,
  });
  Map<dynamic, dynamic> toJson() {
    final Map<dynamic, dynamic> data = <dynamic, dynamic>{};
    data['tb_institution_id'] = tbInstitutionId;
    data['page'] = page;
    data['number'] = number;
    data['tb_user_id'] = tbUserId;
    data['nick_trade'] = nickTrade;
    return data;
  }
}
