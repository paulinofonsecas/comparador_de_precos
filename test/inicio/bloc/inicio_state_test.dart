// ignore_for_file: prefer_const_constructors

import 'package:flutter_test/flutter_test.dart';
import 'package:comparador_de_precos/features/client/inicio/bloc/bloc.dart';

void main() {
  group('InicioState', () {
    test('supports value equality', () {
      expect(
        InicioState(),
        equals(
          const InicioState(),
        ),
      );
    });

    group('constructor', () {
      test('can be instantiated', () {
        expect(
          const InicioState(),
          isNotNull,
        );
      });
    });

    group('copyWith', () {
      test(
        'copies correctly '
        'when no argument specified',
        () {
          const inicioState = InicioState(
            customProperty: 'My property',
          );
          expect(
            inicioState.copyWith(),
            equals(inicioState),
          );
        },
      );

      test(
        'copies correctly '
        'when all arguments specified',
        () {
          const inicioState = InicioState(
            customProperty: 'My property',
          );
          final otherInicioState = InicioState(
            customProperty: 'My property 2',
          );
          expect(inicioState, isNot(equals(otherInicioState)));

          expect(
            inicioState.copyWith(
              customProperty: otherInicioState.customProperty,
            ),
            equals(otherInicioState),
          );
        },
      );
    });
  });
}
