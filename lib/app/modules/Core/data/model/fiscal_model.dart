import 'package:appweb/app/modules/Core/data/model/company_model.dart';
import 'package:appweb/app/modules/Core/data/model/obj_entity_model.dart';
import 'package:appweb/app/modules/Core/data/model/person_model.dart';
import 'package:appweb/app/modules/Core/domain/entity/fiscal_entity.dart';

class FiscalModel extends FiscalEntity {
  FiscalModel({
    required ObjEntityModel objEntity,
    CompanyModel? company,
    PersonModel? person,
  }) : super(
          objEntity: objEntity,
          company: company,
          person: person,
        );

  factory FiscalModel.fromJson(Map<String, dynamic> json) {
    return FiscalModel(
      objEntity: ObjEntityModel.fromJson(json['obj_entity']),
      company: json['company'] != null
          ? CompanyModel.fromJson(json['company'])
          : CompanyModel(
              cnpj: "",
              id: json['entity']['id'],
              ie: "",
            ),
      person: json['person'] != null
          ? PersonModel.fromJson(json['person'])
          : PersonModel(
              cpf: "",
              id: json['entity']['id'],
              rg: "",
            ),
    );
  }

  Map<dynamic, dynamic> toJson() {
    final Map<dynamic, dynamic> data = <dynamic, dynamic>{};
    data['obj_entity'] = objEntity.toJson();
    data['company'] = company?.toJson();
    data['person'] = person?.toJson();
    return data;
  }

  factory FiscalModel.empty() {
    return FiscalModel(
      objEntity: ObjEntityModel.empty(),
      company: CompanyModel.empty(),
      person: PersonModel.empty(),
    );
  }
}
