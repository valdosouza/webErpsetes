import 'package:appweb/app/modules/Core/data/model/fiscal_model.dart';
import 'package:appweb/app/modules/Core/data/model/user_email_model.dart';
import 'package:appweb/app/modules/collaborator_register/data/model/collaborator_model.dart';

class CollaboratorMainEntity {
  CollaboratorModel collaborator;
  FiscalModel fiscal;
  UserEmailModel userEmail;
  CollaboratorMainEntity({
    required this.collaborator,
    required this.fiscal,
    required this.userEmail,
  });
}
