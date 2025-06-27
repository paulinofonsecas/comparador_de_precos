// ignore_for_file: prefer_const_constructors

import 'package:flutter_test/flutter_test.dart';
import 'package:comparador_de_precos/features/admin/admin_gestao_lojas/bloc/bloc.dart';

void main() {
  group('AdminGestaoLojasState', () {
    test('supports value equality', () {
      expect(
        AdminGestaoLojasState(),
        equals(
          const AdminGestaoLojasState(),
        ),
      );
    });

    group('constructor', () {
      test('can be instantiated', () {
        expect(
          const AdminGestaoLojasState(),
          isNotNull,
        );
      });
    });

    group('copyWith', () {
      test(
        'copies correctly '
        'when no argument specified',
        () {
          const adminGestaoLojasState = AdminGestaoLojasState(
            customProperty: 'My property',
          );
          expect(
            adminGestaoLojasState.copyWith(),
            equals(adminGestaoLojasState),
          );
        },
      );

      test(
        'copies correctly '
        'when all arguments specified',
        () {
          const adminGestaoLojasState = AdminGestaoLojasState(
            customProperty: 'My property',
          );
          final otherAdminGestaoLojasState = AdminGestaoLojasState(
            customProperty: 'My property 2',
          );
          expect(adminGestaoLojasState, isNot(equals(otherAdminGestaoLojasState)));

          expect(
            adminGestaoLojasState.copyWith(
              customProperty: otherAdminGestaoLojasState.customProperty,
            ),
            equals(otherAdminGestaoLojasState),
          );
        },
      );
    });
  });
}
