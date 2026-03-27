import 'package:appweb/app/modules/auth/data/model/auth_model.dart';
import 'package:appweb/app/modules/auth/domain/usecase/login_email.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../helpers/mocktail_auth.dart';
import '../test_config.dart';

void main() {
  setUpAll(() {
    configureTestEnvironment();
    registerAuthRepositoryFallbacks();
  });

  late MockAuthRepository repository;
  late LoginEmail usecase;

  setUp(() {
    repository = MockAuthRepository();
    usecase = LoginEmail(repository: repository);
  });

  test('LoginEmail returns auth model when repository succeeds', () async {
    const auth = AuthModel(
      auth: true,
      id: 7,
      tbInstitutionId: 3,
      username: 'user@test.com',
      password: 'hash',
      jwt: 'jwt-token',
      message: '',
    );
    when(
      () => repository.loginEmail(
        username: any(named: 'username'),
        password: any(named: 'password'),
      ),
    ).thenAnswer((_) async => const Right(auth));

    final result = await usecase(
      const Params(username: 'user@test.com', password: 'secret'),
    );

    expect(result, const Right(auth));
    verify(
      () => repository.loginEmail(username: 'user@test.com', password: 'secret'),
    ).called(1);
  });
}
