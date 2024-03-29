import 'dart:convert';

import 'package:appweb/app/modules/auth/data/model/auth_model.dart';
import 'package:appweb/app/modules/auth/domain/entity/auth_entity.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../../fixtures/fixture_reader.dart';

void main() {
  const tAuthModel = AuthModel(
    auth: true,
    id: 2,
    tbInstitutionId: 1,
    username: 'valdo@setes.com.br',
    password: '827CCB0EEA8A706C4C34A16891F84E7B',
    jwt: "StringJWT",
    message: "",
  );
  test('Should be a subclass of AuthEntity', () async {
    // assert
    expect(tAuthModel, isA<AuthEntity>());
  });

  test(
    'should return a valid model the JSON Auth',
    () async {
      // arrange
      final String jsonString = fixture('auth.json');

      final jsonMap = json.decode(jsonString) as Map<String, dynamic>;
      // act

      final result = AuthModel.fromJson(jsonMap);

      // assert
      expect(result.toString(), tAuthModel.toString());
    },
  );
}
