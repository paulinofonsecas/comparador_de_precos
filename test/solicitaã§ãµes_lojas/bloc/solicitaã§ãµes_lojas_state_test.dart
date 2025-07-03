// ignore_for_file: prefer_const_constructors

import 'package:flutter_test/flutter_test.dart';
import 'package:comparador_de_precos/features/admin/solicitaã§ãµes_lojas/bloc/bloc.dart';

void main() {
  group('Solicitaã§ãµesLojasState', () {
    test('supports value equality', () {
      expect(
        Solicitaã§ãµesLojasState(),
        equals(
          const Solicitaã§ãµesLojasState(),
        ),
      );
    });

    group('constructor', () {
      test('can be instantiated', () {
        expect(
          const Solicitaã§ãµesLojasState(),
          isNotNull,
        );
      });
    });

    group('copyWith', () {
      test(
        'copies correctly '
        'when no argument specified',
        () {
          const solicitaã§ãµesLojasState = Solicitaã§ãµesLojasState(
            customProperty: 'My property',
          );
          expect(
            solicitaã§ãµesLojasState.copyWith(),
            equals(solicitaã§ãµesLojasState),
          );
        },
      );

      test(
        'copies correctly '
        'when all arguments specified',
        () {
          const solicitaã§ãµesLojasState = Solicitaã§ãµesLojasState(
            customProperty: 'My property',
          );
          final otherSolicitaã§ãµesLojasState = Solicitaã§ãµesLojasState(
            customProperty: 'My property 2',
          );
          expect(solicitaã§ãµesLojasState, isNot(equals(otherSolicitaã§ãµesLojasState)));

          expect(
            solicitaã§ãµesLojasState.copyWith(
              customProperty: otherSolicitaã§ãµesLojasState.customProperty,
            ),
            equals(otherSolicitaã§ãµesLojasState),
          );
        },
      );
    });
  });
}
