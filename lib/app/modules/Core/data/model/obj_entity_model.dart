import 'package:appweb/app/modules/Core/data/model/address_model.dart';
import 'package:appweb/app/modules/Core/data/model/entity_list_model.dart';
import 'package:appweb/app/modules/Core/data/model/phone_model.dart';
import 'package:appweb/app/modules/Core/domain/entity/obj_entity_entity.dart';

class ObjEntityModel extends ObjEntityEntity {
  ObjEntityModel({
    required String description,
    required int tbInstitutionId,
    required int webId,
    required int terminal,
    required int page,
    required String dateChange,
    required String cnpjInstitution,
    required EntityListModel entity,
    required List<AddressModel> addressList,
    required List<PhoneModel?> phoneList,
  }) : super(
          description: description,
          tbInstitutionId: tbInstitutionId,
          webId: webId,
          terminal: terminal,
          page: page,
          dateChange: dateChange,
          cnpjInstitution: cnpjInstitution,
          entity: entity,
          addressList: addressList,
          phoneList: phoneList,
        );

  factory ObjEntityModel.fromJson(Map<String, dynamic> json) {
    return ObjEntityModel(
      description: json[''],
      tbInstitutionId: json[''],
      webId: json[''],
      terminal: json[''],
      page: json[''],
      dateChange: json[''],
      cnpjInstitution: json[''],
      entity: EntityListModel.fromJson(json['entity']),
      addressList: List<AddressModel>.from(
        json["address_list"].map(
          (x) => AddressModel.fromJson(x),
        ),
      ),
      phoneList: List<PhoneModel>.from(
        json["phone_list"].map(
          (x) => PhoneModel.fromJson(x),
        ),
      ),
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
