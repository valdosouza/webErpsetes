import 'package:appweb/app/modules/Core/data/model/address_model.dart';
import 'package:appweb/app/modules/Core/data/model/entity_list_model.dart';
import 'package:appweb/app/modules/Core/data/model/phone_model.dart';
import 'package:appweb/app/modules/Core/domain/entity/obj_entity_entity.dart';

class ObjEntityModel extends ObjEntityEntity {
  ObjEntityModel({
    required super.description,
    required super.tbInstitutionId,
    required super.webId,
    required super.terminal,
    required super.page,
    required super.dateChange,
    required super.cnpjInstitution,
    required super.entity,
    required super.addressList,
    required super.phoneList,
  });

  factory ObjEntityModel.fromJson(Map<String, dynamic> json) {
    return ObjEntityModel(
      description: json['description'],
      tbInstitutionId: json['tb_institution_id'],
      webId: json['web_id'],
      terminal: json['terminal'],
      page: json['page'],
      dateChange: json['date_change'],
      cnpjInstitution: json['cnpj_institution'],
      entity: EntityListModel.fromJson(json['entity']),
      addressList: json["address_list"].length > 0
          ? List<AddressModel>.from(
              json["address_list"].map(
                (x) => AddressModel.fromJson(x),
              ),
            )
          : AddressModel().emptyList(json['entity']['id']),
      phoneList: json["phone_list"].length > 0
          ? List<PhoneModel>.from(json["phone_list"].map(
              (x) => PhoneModel.fromJson(x),
            ))
          : PhoneModel().emptyList(json['entity']['id']),
    );
  }

  Map<dynamic, dynamic> toJson() {
    final Map<dynamic, dynamic> data = <dynamic, dynamic>{};
    data['description'] = description;
    data['tbInstitutionIid'] = tbInstitutionId;
    data['webId'] = webId;
    data['terminal'] = terminal;
    data['page'] = page;
    data['dateChange'] = dateChange;
    data['cnpjInstitution'] = cnpjInstitution;
    data['entity'] = entity.toJson();
    data['address_list'] = addressList.map((e) => e.toJson()).toList();
    data['phone_list'] = phoneList.map((e) => e?.toJson()).toList();
    return data;
  }

  factory ObjEntityModel.empty() {
    return ObjEntityModel(
      description: '',
      tbInstitutionId: 0,
      webId: 0,
      terminal: 0,
      page: 0,
      dateChange: '',
      cnpjInstitution: '',
      entity: EntityListModel.empty(),
      addressList: [AddressModel.empty()],
      phoneList: [PhoneModel.empty()],
    );
  }
}
