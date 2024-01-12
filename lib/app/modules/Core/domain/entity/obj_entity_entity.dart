import 'package:appweb/app/modules/Core/data/model/address_model.dart';
import 'package:appweb/app/modules/Core/data/model/entity_list_model.dart';
import 'package:appweb/app/modules/Core/data/model/phone_model.dart';

class ObjEntityEntity {
  String description;
  int tbInstitutionId;
  int webId;
  int terminal;
  int page;
  String dateChange;
  String cnpjInstitution;
  EntityListModel entity;
  List<AddressModel> addressList;
  List<PhoneModel?> phoneList;
  ObjEntityEntity({
    required this.description,
    required this.tbInstitutionId,
    required this.webId,
    required this.terminal,
    required this.page,
    required this.dateChange,
    required this.cnpjInstitution,
    required this.entity,
    required this.addressList,
    required this.phoneList,
  });
}
