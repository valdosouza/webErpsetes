// Mocks generated by Mockito 5.3.2 from annotations
// in appweb/test/app/modules/home/domain/usecase/get_financial_closed_usecase_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i4;

import 'package:appweb/app/core/error/failures.dart' as _i5;
import 'package:appweb/app/modules/home/data/model/home_sales_payment_type_model.dart'
    as _i6;
import 'package:appweb/app/modules/home/domain/repository/home_repository.dart'
    as _i3;
import 'package:dartz/dartz.dart' as _i2;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeEither_0<L, R> extends _i1.SmartFake implements _i2.Either<L, R> {
  _FakeEither_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [HomeRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockHomeRepository extends _i1.Mock implements _i3.HomeRepository {
  MockHomeRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<_i2.Either<_i5.Failure, List<_i6.HomeSalesPaymentTypeModel>>>
      getFinancialClosed({
    required String? initialDate,
    required String? finalDate,
    required String? terminal,
  }) =>
          (super.noSuchMethod(
            Invocation.method(
              #getFinancialClosed,
              [],
              {
                #initialDate: initialDate,
                #finalDate: finalDate,
                #terminal: terminal,
              },
            ),
            returnValue: _i4.Future<
                    _i2.Either<_i5.Failure,
                        List<_i6.HomeSalesPaymentTypeModel>>>.value(
                _FakeEither_0<_i5.Failure, List<_i6.HomeSalesPaymentTypeModel>>(
              this,
              Invocation.method(
                #getFinancialClosed,
                [],
                {
                  #initialDate: initialDate,
                  #finalDate: finalDate,
                  #terminal: terminal,
                },
              ),
            )),
          ) as _i4.Future<
              _i2.Either<_i5.Failure, List<_i6.HomeSalesPaymentTypeModel>>>);
}
