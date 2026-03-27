import 'package:appweb/app/modules/auth/data/model/auth_change_password_model.dart';
import 'package:appweb/app/modules/auth/data/model/auth_recovery_password_model.dart';
import 'package:appweb/app/modules/auth/domain/repository/auth_repository.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

void registerAuthRepositoryFallbacks() {
  registerFallbackValue(AuthChangePasswordModel(
    tbUserId: 0,
    salt: '',
    newPassword: '',
  ));
  registerFallbackValue(AuthRecoveryPasswordModel.empty());
}
