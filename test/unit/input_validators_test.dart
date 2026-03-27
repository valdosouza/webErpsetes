import 'package:appweb/app/core/shared/utils/input_validators.dart';
import 'package:flutter_test/flutter_test.dart';

import '../test_config.dart';

void main() {
  setUpAll(configureTestEnvironment);

  group('InputValidators.isValidEmail', () {
    test('returns true for typical corporate email', () {
      expect(InputValidators.isValidEmail('user@setes.com.br'), isTrue);
    });

    test('returns false for missing @ and domain', () {
      expect(InputValidators.isValidEmail('notanemail'), isFalse);
    });
  });

  group('InputValidators.emailError', () {
    test('returns obrigatório when empty', () {
      expect(InputValidators.emailError(''), isNotNull);
      expect(InputValidators.emailError('  '), isNotNull);
    });

    test('returns null when email is valid', () {
      expect(InputValidators.emailError('a@b.co'), isNull);
    });
  });

  group('InputValidators.passwordError', () {
    test('returns obrigatório when null or empty', () {
      expect(InputValidators.passwordError(null), isNotNull);
      expect(InputValidators.passwordError(''), isNotNull);
    });

    test('returns length hint when below minLength', () {
      expect(InputValidators.passwordError('ab', minLength: 6), isNotNull);
    });

    test('returns null when password meets minLength', () {
      expect(InputValidators.passwordError('secret', minLength: 6), isNull);
    });
  });
}
