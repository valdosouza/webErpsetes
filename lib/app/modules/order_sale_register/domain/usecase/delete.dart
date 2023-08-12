import 'package:appweb/app/core/error/exceptions.dart';
import 'package:appweb/app/core/error/failures.dart';
import 'package:appweb/app/modules/Core/domain/usecase/usecase.dart';
import 'package:appweb/app/modules/order_sale_register/domain/repository/respository.dart';
import 'package:dartz/dartz.dart';

class Delete implements UseCase<bool, ParamsDeleteOrder> {
  final Repository repository;

  Delete({required this.repository});

  @override
  Future<Either<Failure, bool>> call(ParamsDeleteOrder params) async {
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
  int? id;
  ParamsDeleteOrder({
    required this.tbInstitutionId,
    this.id,
  });
  Map<dynamic, dynamic> toJson() {
    final Map<dynamic, dynamic> data = <dynamic, dynamic>{};
    data['tb_institution_id'] = tbInstitutionId;
    data['id'] = id;
    return data;
  }
}
