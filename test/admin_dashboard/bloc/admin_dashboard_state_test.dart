// ignore_for_file: prefer_const_constructors

import 'package:flutter_test/flutter_test.dart';
import 'package:comparador_de_precos/features/admin/admin_dashboard/bloc/bloc.dart';

void main() {
  group('AdminDashboardState', () {
    test('supports value equality', () {
      expect(
        AdminDashboardState(),
        equals(
          const AdminDashboardState(),
        ),
      );
    });

    group('constructor', () {
      test('can be instantiated', () {
        expect(
          const AdminDashboardState(),
          isNotNull,
        );
      });
    });

    group('copyWith', () {
      test(
        'copies correctly '
        'when no argument specified',
        () {
          const adminDashboardState = AdminDashboardState(
            customProperty: 'My property',
          );
          expect(
            adminDashboardState.copyWith(),
            equals(adminDashboardState),
          );
        },
      );

      test(
        'copies correctly '
        'when all arguments specified',
        () {
          const adminDashboardState = AdminDashboardState(
            customProperty: 'My property',
          );
          final otherAdminDashboardState = AdminDashboardState(
            customProperty: 'My property 2',
          );
          expect(adminDashboardState, isNot(equals(otherAdminDashboardState)));

          expect(
            adminDashboardState.copyWith(
              customProperty: otherAdminDashboardState.customProperty,
            ),
            equals(otherAdminDashboardState),
          );
        },
      );
    });
  });
}
