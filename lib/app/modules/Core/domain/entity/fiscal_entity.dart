import 'package:appweb/app/modules/Core/data/model/company_model.dart';
import 'package:appweb/app/modules/Core/data/model/obj_entity_model.dart';
import 'package:appweb/app/modules/Core/data/model/person_model.dart';

class FiscalEntity {
  ObjEntityModel objEntity;
  CompanyModel? company;
  PersonModel? person;
  FiscalEntity({
    required this.objEntity,
    required this.company,
    required this.person,
  });
}
