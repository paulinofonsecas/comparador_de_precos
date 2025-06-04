// ignore_for_file: prefer_const_constructors

import 'package:flutter_test/flutter_test.dart';
import 'package:comparador_de_precos/features/logista/solicitar_cadastro/bloc/bloc.dart';

void main() {
  group('SolicitarCadastroState', () {
    test('supports value equality', () {
      expect(
        SolicitarCadastroState(),
        equals(
          const SolicitarCadastroState(),
        ),
      );
    });

    group('constructor', () {
      test('can be instantiated', () {
        expect(
          const SolicitarCadastroState(),
          isNotNull,
        );
      });
    });

    group('copyWith', () {
      test(
        'copies correctly '
        'when no argument specified',
        () {
          const solicitarCadastroState = SolicitarCadastroState(
            customProperty: 'My property',
          );
          expect(
            solicitarCadastroState.copyWith(),
            equals(solicitarCadastroState),
          );
        },
      );

      test(
        'copies correctly '
        'when all arguments specified',
        () {
          const solicitarCadastroState = SolicitarCadastroState(
            customProperty: 'My property',
          );
          final otherSolicitarCadastroState = SolicitarCadastroState(
            customProperty: 'My property 2',
          );
          expect(solicitarCadastroState, isNot(equals(otherSolicitarCadastroState)));

          expect(
            solicitarCadastroState.copyWith(
              customProperty: otherSolicitarCadastroState.customProperty,
            ),
            equals(otherSolicitarCadastroState),
          );
        },
      );
    });
  });
}
