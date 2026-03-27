import 'test_harness.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Flow 1: landing -> main content', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: FlowOneStart(),
      ),
    );

    expect(find.text('Integration landing'), findsOneWidget);
    await tester.tap(find.text('Ir para principal'));
    await tester.pumpAndSettle();

    expect(find.text('Conteúdo principal do app'), findsOneWidget);
    expect(find.text('Principal'), findsOneWidget);
  });

  testWidgets('Flow 2: fake login -> workspace -> add item', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: FakeLoginPage(),
      ),
    );

    await tester.enterText(find.byKey(const Key('login_user')), 'demo');
    await tester.enterText(find.byKey(const Key('login_pass')), 'demo');
    await tester.tap(find.text('Entrar'));
    await tester.pumpAndSettle();

    expect(find.text('Workspace'), findsOneWidget);

    await tester.enterText(find.byKey(const Key('item_name')), 'Item teste');
    await tester.tap(find.text('Adicionar'));
    await tester.pump();

    expect(find.text('Item teste'), findsOneWidget);
    expect(find.byKey(const Key('fake_saved_hint')), findsOneWidget);
  });
}
