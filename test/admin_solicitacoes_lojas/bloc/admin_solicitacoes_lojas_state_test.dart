// ignore_for_file: prefer_const_constructors

import 'package:flutter_test/flutter_test.dart';
import 'package:comparador_de_precos/features/admin/admin_solicitacoes_lojas/bloc/bloc.dart';

void main() {
  group('AdminSolicitacoesLojasState', () {
    test('supports value equality', () {
      expect(
        AdminSolicitacoesLojasState(),
        equals(
          const AdminSolicitacoesLojasState(),
        ),
      );
    });

    group('constructor', () {
      test('can be instantiated', () {
        expect(
          const AdminSolicitacoesLojasState(),
          isNotNull,
        );
      });
    });

    group('copyWith', () {
      test(
        'copies correctly '
        'when no argument specified',
        () {
          const adminSolicitacoesLojasState = AdminSolicitacoesLojasState(
            customProperty: 'My property',
          );
          expect(
            adminSolicitacoesLojasState.copyWith(),
            equals(adminSolicitacoesLojasState),
          );
        },
      );

      test(
        'copies correctly '
        'when all arguments specified',
        () {
          const adminSolicitacoesLojasState = AdminSolicitacoesLojasState(
            customProperty: 'My property',
          );
          final otherAdminSolicitacoesLojasState = AdminSolicitacoesLojasState(
            customProperty: 'My property 2',
          );
          expect(adminSolicitacoesLojasState, isNot(equals(otherAdminSolicitacoesLojasState)));

          expect(
            adminSolicitacoesLojasState.copyWith(
              customProperty: otherAdminSolicitacoesLojasState.customProperty,
            ),
            equals(otherAdminSolicitacoesLojasState),
          );
        },
      );
    });
  });
}
