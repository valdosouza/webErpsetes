import 'package:appweb/app/core/error/exceptions.dart';
import 'package:appweb/app/core/error/failures.dart';
import 'package:appweb/app/modules/Core/data/model/customer_list_model.dart';
import 'package:appweb/app/modules/Core/domain/usecase/usecase.dart';
import 'package:appweb/app/modules/order_sale_register/domain/repository/respository.dart';
import 'package:dartz/dartz.dart';

class GetCustomerList
    implements UseCase<List<CustomerListModel>, ParamsCustomerList> {
  final Repository repository;

  GetCustomerList({required this.repository});

  @override
  Future<Either<Failure, List<CustomerListModel>>> call(
      ParamsCustomerList params) async {
    try {
      final list = await repository.getCustomerList(params: params);
      return list;
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}

class ParamsCustomerList {
  int tbInstitutionId;
  int page;
  int? id;
  int tbSalesmanId;
  String? nameCustomer;
  ParamsCustomerList({
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
