import 'package:appweb/app/core/shared/utils/input_validators.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../test_config.dart';

void main() {
  setUpAll(configureTestEnvironment);

  testWidgets('Form shows email error when value is invalid', (tester) async {
    final formKey = GlobalKey<FormState>();

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Form(
            key: formKey,
            child: Column(
              children: [
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Email'),
                  validator: InputValidators.emailError,
                ),
                ElevatedButton(
                  onPressed: () => formKey.currentState!.validate(),
                  child: const Text('Enviar'),
                ),
              ],
            ),
          ),
        ),
      ),
    );

    await tester.enterText(find.byType(TextFormField), 'invalido');
    await tester.tap(find.text('Enviar'));
    await tester.pump();

    expect(find.text('E-mail inválido'), findsOneWidget);
  });

  testWidgets('Password field clears error after valid input', (tester) async {
    final formKey = GlobalKey<FormState>();

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Form(
            key: formKey,
            child: Column(
              children: [
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Senha'),
                  validator: (v) => InputValidators.passwordError(v, minLength: 4),
                ),
                ElevatedButton(
                  onPressed: () => formKey.currentState!.validate(),
                  child: const Text('Validar'),
                ),
              ],
            ),
          ),
        ),
      ),
    );

    await tester.enterText(find.byType(TextFormField), 'ab');
    await tester.tap(find.text('Validar'));
    await tester.pump();
    expect(find.textContaining('Mínimo'), findsOneWidget);

    await tester.enterText(find.byType(TextFormField), 'abcd');
    await tester.tap(find.text('Validar'));
    await tester.pump();

    expect(find.textContaining('Mínimo'), findsNothing);
  });
}
