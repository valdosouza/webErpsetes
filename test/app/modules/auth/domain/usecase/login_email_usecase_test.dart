import 'package:appweb/app/modules/auth/data/model/auth_model.dart';
import 'package:appweb/app/modules/auth/domain/repository/auth_repository.dart';
import 'package:appweb/app/modules/auth/domain/usecase/login_email.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'login_email_usecase_test.mocks.dart';

@GenerateMocks([AuthRepository])
void main() {
  late LoginEmail usecase;
  late MockAuthRepository mockAuthRepository;

  late Params tParams;
  setUp(() {
    mockAuthRepository = MockAuthRepository();
    usecase = LoginEmail(repository: mockAuthRepository);
  });
  const tAuthModel = AuthModel(
    auth: true,
    id: 0,
    tbInstitutionId: 0,
    username: 'testEmail@Email',
    password: '123',
    jwt: 'StringJWT',
    message: "",
  );
  tParams = Params(
    username: tAuthModel.username,
    password: tAuthModel.password,
  );
  test(
    'should get JWT auth  API',
    () async {
      // arrange
      when(mockAuthRepository.loginEmail(
              username: tAuthModel.username, password: tAuthModel.password))
          .thenAnswer((_) async => const Right(tAuthModel));
      // act
      final result = await usecase(tParams);
      // assert
      expect(result, const Right(tAuthModel));
      verify(mockAuthRepository.loginEmail(
          username: tAuthModel.username, password: tAuthModel.password));
      verifyNoMoreInteractions(mockAuthRepository);
    },
  );
}
