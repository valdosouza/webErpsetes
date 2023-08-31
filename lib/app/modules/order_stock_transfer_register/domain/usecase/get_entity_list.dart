import 'package:appweb/app/core/error/exceptions.dart';
import 'package:appweb/app/core/error/failures.dart';
import 'package:appweb/app/modules/order_stock_transfer_register/data/model/entity_list_model.dart';
import 'package:appweb/app/modules/Core/domain/usecase/usecase.dart';
import 'package:appweb/app/modules/order_stock_transfer_register/domain/repository/respository.dart';
import 'package:dartz/dartz.dart';

class GetEntityList
    implements UseCase<List<EntityListModel>, ParamsEntityList> {
  final Repository repository;

  GetEntityList({required this.repository});

  @override
  Future<Either<Failure, List<EntityListModel>>> call(
      ParamsEntityList params) async {
    try {
      final list = await repository.getEntityList(params: params);
      return list;
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}

class ParamsEntityList {
  int tbInstitutionId;
  int page;
  int? id;
  int tbSalesmanId;
  String? nameEntity;
  ParamsEntityList({
    required this.tbInstitutionId,
    required this.page,
    required this.tbSalesmanId,
    this.id,
    this.nameEntity,
  });
  Map<dynamic, dynamic> toJson() {
    final Map<dynamic, dynamic> data = <dynamic, dynamic>{};
    data['tb_institution_id'] = tbInstitutionId;
    data['page'] = page;
    data['id'] = id;
    data['tb_salesman_id'] = tbSalesmanId;
    data['name_entity'] = nameEntity;

    return data;
  }
}
