import 'package:appweb/app/core/error/exceptions.dart';
import 'package:appweb/app/core/error/failures.dart';
import 'package:appweb/app/core/shared/utils/custom_date.dart';
import 'package:appweb/app/modules/Core/data/model/order_result_action_model.dart';
import 'package:appweb/app/modules/Core/domain/usecase/usecase.dart';
import 'package:appweb/app/modules/order_bonus_register/domain/repository/respository.dart';
import 'package:dartz/dartz.dart';

class Closure implements UseCase<OrderResultActionModel, ParamsClosureOrder> {
  final Repository repository;

  Closure({required this.repository});

  @override
  Future<Either<Failure, OrderResultActionModel>> call(
      ParamsClosureOrder params) async {
    try {
      final response = await repository.closure(params: params);
      return response;
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}

class ParamsClosureOrder {
  int tbInstitutionId;
  int tbOrderId;
  int tbUserId;
  String dtRecord;
  ParamsClosureOrder({
    required this.tbInstitutionId,
    required this.tbOrderId,
    required this.tbUserId,
    required this.dtRecord,
  });
  Map<dynamic, dynamic> toJson() {
    final Map<dynamic, dynamic> data = <dynamic, dynamic>{};
    data['tb_institution_id'] = tbInstitutionId;
    data['tb_order_id'] = tbOrderId;
    data['tb_user_id'] = tbUserId;
    data['dt_record'] = CustomDate.formatDateOut(dtRecord);
    return data;
  }
}
