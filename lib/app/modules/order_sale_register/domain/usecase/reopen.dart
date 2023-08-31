import 'package:appweb/app/core/error/exceptions.dart';
import 'package:appweb/app/core/error/failures.dart';
import 'package:appweb/app/core/shared/utils/custom_date.dart';
import 'package:appweb/app/modules/Core/data/model/order_result_action_model.dart';
import 'package:appweb/app/modules/Core/domain/usecase/usecase.dart';
import 'package:appweb/app/modules/order_sale_register/domain/repository/respository.dart';
import 'package:dartz/dartz.dart';

class Reopen implements UseCase<OrderResultActionModel, ParamsReopenOrder> {
  final Repository repository;

  Reopen({required this.repository});

  @override
  Future<Either<Failure, OrderResultActionModel>> call(
      ParamsReopenOrder params) async {
    try {
      final response = await repository.reopen(params: params);
      return response;
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}

class ParamsReopenOrder {
  int tbInstitutionId;
  int tbOrderId;
  int tbUserId;
  String dtRecord;
  ParamsReopenOrder({
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
