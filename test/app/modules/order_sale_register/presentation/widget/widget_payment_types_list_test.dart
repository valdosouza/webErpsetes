import 'package:appweb/app/modules/order_sale_register/data/model/payment_types_list_model.dart';
import 'package:appweb/app/modules/order_sale_register/presentation/widget/widget_payment_types_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../../helpers/order_sale_register_test_bloc.dart';
import '../../../../../test_config.dart';

void main() {
  setUpAll(configureTestEnvironment);

  testWidgets('lists payment descriptions when data is non-empty', (tester) async {
    final bloc = buildOrderSaleRegisterTestBloc();
    final list = [
      PaymentTypesListModel(
        id: 1,
        tbInstitutionId: 1,
        description: 'PIX',
        active: 'S',
      ),
      PaymentTypesListModel(
        id: 2,
        tbInstitutionId: 1,
        description: 'Boleto',
        active: 'S',
      ),
    ];

    await tester.pumpWidget(
      MaterialApp(
        home: WidgetPaymentTypesList(
          paymentTypesList: list,
          injectedBloc: bloc,
        ),
      ),
    );

    expect(find.text('PIX'), findsOneWidget);
    expect(find.text('Boleto'), findsOneWidget);
    expect(find.textContaining('Lista de Forma de Pagamentos'), findsOneWidget);
  });

  testWidgets('shows empty message when list is empty', (tester) async {
    final bloc = buildOrderSaleRegisterTestBloc();

    await tester.pumpWidget(
      MaterialApp(
        home: WidgetPaymentTypesList(
          paymentTypesList: const [],
          injectedBloc: bloc,
        ),
      ),
    );

    expect(
      find.text('Não encontramos nenhum registro em nossa base.'),
      findsOneWidget,
    );
  });
}
