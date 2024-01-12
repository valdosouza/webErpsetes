import 'package:appweb/app/core/error/exceptions.dart';
import 'package:appweb/app/core/error/failures.dart';
import 'package:appweb/app/modules/Core/data/model/customer_list_model.dart';
import 'package:appweb/app/modules/Core/domain/usecase/usecase.dart';
import 'package:appweb/app/modules/customer_register/data/model/customer_main_model.dart';
import 'package:appweb/app/modules/customer_register/domain/repository/respository.dart';
import 'package:dartz/dartz.dart';

class Post implements UseCase<CustomerListModel, ParamsPostCustomer> {
  final Repository repository;

  Post({required this.repository});

  @override
  Future<Either<Failure, CustomerListModel>> call(
      ParamsPostCustomer params) async {
    try {
      final model = await repository.post(customer: params.customer);
      return model;
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}

class ParamsPostCustomer {
  CustomerMainModel customer;
  ParamsPostCustomer({required this.customer});
}
