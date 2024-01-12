import 'package:appweb/app/core/error/exceptions.dart';
import 'package:appweb/app/core/error/failures.dart';
import 'package:appweb/app/modules/Core/data/model/customer_list_model.dart';
import 'package:appweb/app/modules/Core/domain/usecase/usecase.dart';
import 'package:appweb/app/modules/customer_register/domain/repository/respository.dart';
import 'package:dartz/dartz.dart';

class GetList implements UseCase<List<CustomerListModel>, ParamsList> {
  final Repository repository;

  GetList({required this.repository});

  @override
  Future<Either<Failure, List<CustomerListModel>>> call(
      ParamsList params) async {
    try {
      final list = await repository.getList(params: params);
      return list;
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}

class ParamsList {
  int tbInstitutionId;
  int page;
  int? id;
  int tbSalesmanId;
  String? nameCustomer;
  ParamsList({
    required this.tbInstitutionId,
    required this.page,
    required this.tbSalesmanId,
    this.id,
    this.nameCustomer,
  });
  Map<dynamic, dynamic> toJson() {
    final Map<dynamic, dynamic> data = <dynamic, dynamic>{};
    data['tb_institution_id'] = tbInstitutionId;
    data['page'] = page;
    data['id'] = id;
    data['tb_salesman_id'] = tbSalesmanId;
    data['name_customer'] = nameCustomer;

    return data;
  }
}
