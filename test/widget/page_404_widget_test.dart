import 'package:appweb/app/core/shared/page_404.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../test_config.dart';

void main() {
  setUpAll(configureTestEnvironment);

  testWidgets('Page404 shows app title and not-found message', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Page404(),
      ),
    );

    expect(find.text('Sistema Gestão - Setes'), findsOneWidget);
    expect(find.text('Página não existe'), findsOneWidget);
  });
}
