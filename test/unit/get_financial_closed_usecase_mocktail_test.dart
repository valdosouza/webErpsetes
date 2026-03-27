import 'package:appweb/app/modules/home/data/model/home_sales_payment_type_model.dart';
import 'package:appweb/app/modules/home/domain/usecase/get_financial_closed_usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../helpers/mocktail_home.dart';
import '../test_config.dart';

void main() {
  setUpAll(configureTestEnvironment);

  late MockHomeRepository repository;
  late GetFinancialClosedUseCase usecase;

  setUp(() {
    repository = MockHomeRepository();
    usecase = GetFinancialClosedUseCase(repository: repository);
  });

  test('forwards dates and terminal to repository', () async {
    const items = [
      HomeSalesPaymentTypeModel(
        paymentType: 'DINHEIRO',
        totalQtty: 1,
        totalValue: 10.0,
      ),
    ];
    when(
      () => repository.getFinancialClosed(
        initialDate: any(named: 'initialDate'),
        finalDate: any(named: 'finalDate'),
        terminal: any(named: 'terminal'),
      ),
    ).thenAnswer((_) async => const Right(items));

    const params = Params(
      initialDate: '2024-01-01',
      finalDate: '2024-01-31',
      terminal: 'T1',
    );

    final result = await usecase(params);

    expect(result, const Right(items));
    verify(
      () => repository.getFinancialClosed(
        initialDate: '2024-01-31',
        finalDate: '2024-01-31',
        terminal: 'T1',
      ),
    ).called(1);
  });
}
