// ignore_for_file: prefer_const_constructors

import 'package:flutter_test/flutter_test.dart';
import 'package:comparador_de_precos/features/logista/logista_produtos_associados/bloc/bloc.dart';

void main() {
  group('LogistaProdutosAssociadosState', () {
    test('supports value equality', () {
      expect(
        LogistaProdutosAssociadosState(),
        equals(
          const LogistaProdutosAssociadosState(),
        ),
      );
    });

    group('constructor', () {
      test('can be instantiated', () {
        expect(
          const LogistaProdutosAssociadosState(),
          isNotNull,
        );
      });
    });

    group('copyWith', () {
      test(
        'copies correctly '
        'when no argument specified',
        () {
          const logistaProdutosAssociadosState = LogistaProdutosAssociadosState(
            customProperty: 'My property',
          );
          expect(
            logistaProdutosAssociadosState.copyWith(),
            equals(logistaProdutosAssociadosState),
          );
        },
      );

      test(
        'copies correctly '
        'when all arguments specified',
        () {
          const logistaProdutosAssociadosState = LogistaProdutosAssociadosState(
            customProperty: 'My property',
          );
          final otherLogistaProdutosAssociadosState = LogistaProdutosAssociadosState(
            customProperty: 'My property 2',
          );
          expect(logistaProdutosAssociadosState, isNot(equals(otherLogistaProdutosAssociadosState)));

          expect(
            logistaProdutosAssociadosState.copyWith(
              customProperty: otherLogistaProdutosAssociadosState.customProperty,
            ),
            equals(otherLogistaProdutosAssociadosState),
          );
        },
      );
    });
  });
}
