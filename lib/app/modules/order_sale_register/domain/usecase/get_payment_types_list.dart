import 'package:appweb/app/core/error/exceptions.dart';
import 'package:appweb/app/core/error/failures.dart';
import 'package:appweb/app/modules/Core/domain/usecase/usecase.dart';
import 'package:appweb/app/modules/order_sale_register/data/model/payment_types_list_model.dart';
import 'package:appweb/app/modules/order_sale_register/domain/repository/respository.dart';
import 'package:dartz/dartz.dart';

class GetPaymentTypesList
    implements UseCase<List<PaymentTypesListModel>, ParamsPaymentList> {
  final Repository repository;

  GetPaymentTypesList({required this.repository});

  @override
  Future<Either<Failure, List<PaymentTypesListModel>>> call(
      ParamsPaymentList params) async {
    try {
      final list = await repository.getPaymentTypesList(params: params);
      return list;
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}

class ParamsPaymentList {
  int tbInstitutionId;
  int page;
  int? id;
  String? namePaymentTypes;
  ParamsPaymentList({
    required this.tbInstitutionId,
    required this.page,
    this.id,
    this.namePaymentTypes,
  });
  Map<dynamic, dynamic> toJson() {
    final Map<dynamic, dynamic> data = <dynamic, dynamic>{};
    data['tb_institution_id'] = tbInstitutionId;
    data['page'] = page;
    data['id'] = id;
    data['name_payment_types'] = namePaymentTypes;

    return data;
  }
}
