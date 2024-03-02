import 'package:appweb/app/core/error/exceptions.dart';
import 'package:appweb/app/core/error/failures.dart';
import 'package:appweb/app/modules/Core/data/model/order_result_action_model.dart';
import 'package:appweb/app/modules/Core/domain/usecase/usecase.dart';
import 'package:appweb/app/modules/order_bonus_register/domain/repository/respository.dart';
import 'package:dartz/dartz.dart';

class Delete implements UseCase<OrderResultActionModel, ParamsDeleteOrder> {
  final Repository repository;

  Delete({required this.repository});

  @override
  Future<Either<Failure, OrderResultActionModel>> call(
      ParamsDeleteOrder params) async {
    try {
      final response = await repository.delete(params: params);
      return response;
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}

class ParamsDeleteOrder {
  int tbInstitutionId;
  int tbOrderId;
  int tbUserId;
  ParamsDeleteOrder({
    required this.tbInstitutionId,
    required this.tbOrderId,
    required this.tbUserId,
  });
  Map<dynamic, dynamic> toJson() {
    final Map<dynamic, dynamic> data = <dynamic, dynamic>{};
    data['tb_institution_id'] = tbInstitutionId;
    data['tb_order_id'] = tbOrderId;
    data['tb_user_id'] = tbUserId;
    return data;
  }
}
