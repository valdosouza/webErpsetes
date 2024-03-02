import 'package:dartz/dartz.dart';

import 'package:appweb/app/core/error/exceptions.dart';
import 'package:appweb/app/core/error/failures.dart';
import 'package:appweb/app/modules/Core/data/model/product_list_model.dart';
import 'package:appweb/app/modules/Core/domain/usecase/usecase.dart';
import 'package:appweb/app/modules/order_bonus_register/domain/repository/respository.dart';

class GetProductList
    implements UseCase<List<ProductListModel>, ParamsProductList> {
  final Repository repository;

  GetProductList({required this.repository});

  @override
  Future<Either<Failure, List<ProductListModel>>> call(
      ParamsProductList params) async {
    try {
      final list = await repository.getProductList(params: params);
      return list;
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}

class ParamsProductList {
  int tbInstitutionId;
  int page;
  int id;
  String nameProduct;
  ParamsProductList({
    required this.tbInstitutionId,
    required this.page,
    required this.id,
    required this.nameProduct,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['tb_institution_id'] = tbInstitutionId;
    data['page'] = page;
    data['id'] = id;
    data['name_product'] = nameProduct;

    return data;
  }
}
