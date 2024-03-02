import 'package:appweb/app/modules/Core/data/model/fiscal_model.dart';
import 'package:appweb/app/modules/Core/data/model/user_email_model.dart';
import 'package:appweb/app/modules/collaborator_register/data/model/collaborator_model.dart';
import 'package:appweb/app/modules/collaborator_register/domain/entity/collaborator_main_entity.dart';

class CollaboratorMainModel extends CollaboratorMainEntity {
  CollaboratorMainModel({
    required super.collaborator,
    required super.fiscal,
    required super.userEmail,
  });

  factory CollaboratorMainModel.fromJson(Map<String, dynamic> json) {
    return CollaboratorMainModel(
      collaborator: CollaboratorModel.fromJson(json['collaborator']),
      fiscal: FiscalModel.fromJson(json['fiscal']),
      userEmail: UserEmailModel.fromJson(json['user']),
    );
  }

  Map<dynamic, dynamic> toJson() {
    final Map<dynamic, dynamic> data = <dynamic, dynamic>{};
    data['collaborator'] = collaborator.toJson();
    data['fiscal'] = fiscal.toJson();
    data['user'] = userEmail.toJson();
    return data;
  }

  factory CollaboratorMainModel.empty() {
    return CollaboratorMainModel(
      collaborator: CollaboratorModel.empty(),
      fiscal: FiscalModel.empty(),
      userEmail: UserEmailModel.empty(),
    );
  }
}
