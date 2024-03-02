import 'package:appweb/app/core/error/exceptions.dart';
import 'package:appweb/app/core/error/failures.dart';
import 'package:appweb/app/modules/Core/domain/usecase/usecase.dart';
import 'package:appweb/app/modules/order_bonus_register/data/model/order_main_model.dart';
import 'package:appweb/app/modules/order_bonus_register/data/model/order_bonus_list_model.dart';
import 'package:appweb/app/modules/order_bonus_register/domain/repository/respository.dart';
import 'package:dartz/dartz.dart';

class Put implements UseCase<OrderBonusListModel, OrderBonusMainModel> {
  final Repository repository;

  Put({required this.repository});

  @override
  Future<Either<Failure, OrderBonusListModel>> call(
      OrderBonusMainModel params) async {
    try {
      final response = await repository.put(params: params);
      return response;
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}