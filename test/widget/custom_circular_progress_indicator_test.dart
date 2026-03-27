import 'package:appweb/app/core/shared/widgets/custom_circular_progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../test_config.dart';

void main() {
  setUpAll(configureTestEnvironment);

  testWidgets('CustomCircularProgressIndicator shows processing labels',
      (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: CustomCircularProgressIndicator(),
      ),
    );

    expect(find.text('Processando'), findsOneWidget);
    expect(find.text('Aguarde..'), findsOneWidget);
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });
}
