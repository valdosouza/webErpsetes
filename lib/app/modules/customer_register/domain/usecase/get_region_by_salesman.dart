import 'package:appweb/app/modules/Core/data/model/region_model.dart';
import 'package:appweb/app/core/error/exceptions.dart';
import 'package:appweb/app/core/error/failures.dart';
import 'package:appweb/app/modules/Core/domain/usecase/usecase.dart';
import 'package:appweb/app/modules/customer_register/domain/repository/get_region_by_saleman_repository.dart';
import 'package:dartz/dartz.dart';

class GetRegionBySalesman
    implements UseCase<List<RegionRegisterModel>, ParamsRegionListGet> {
  final GetRegionBySalesmanRepository repository;

  GetRegionBySalesman({required this.repository});

  @override
  Future<Either<Failure, List<RegionRegisterModel>>> call(
      ParamsRegionListGet params) async {
    try {
      final list = await repository.getList();
      return list;
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}

class ParamsRegionListGet {
  ParamsRegionListGet();
}
