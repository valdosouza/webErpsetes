import 'package:appweb/app/modules/order_sale_register/data/model/product_prices_model.dart';
import 'package:appweb/app/modules/order_sale_register/presentation/widget/widget_product_prices.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../../helpers/order_sale_register_test_bloc.dart';
import '../../../../../test_config.dart';

void main() {
  setUpAll(configureTestEnvironment);

  testWidgets('shows title and product summary with injected bloc', (tester) async {
    final bloc = buildOrderSaleRegisterTestBloc();
    final model = ProductPricesModel(
      tbInstitutionId: 1,
      id: 7,
      nameProduct: 'Produto teste',
      items: [
        PricesModel(id: 1, namePriceList: 'Lista A', priceTag: 12.5),
        PricesModel(id: 2, namePriceList: 'Lista B', priceTag: 11.0),
      ],
    );

    await tester.pumpWidget(
      MaterialApp(
        home: WidgetProductPrices(
          productPrices: model,
          injectedBloc: bloc,
        ),
      ),
    );

    expect(find.text('Preços Disponiveis'), findsOneWidget);
    expect(find.textContaining('7 - Produto teste'), findsOneWidget);
    expect(find.text('Lista A'), findsOneWidget);
    expect(find.text('12.50'), findsOneWidget);
  });
}
