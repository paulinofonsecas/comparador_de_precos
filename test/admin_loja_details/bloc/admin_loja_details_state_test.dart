// ignore_for_file: prefer_const_constructors

import 'package:flutter_test/flutter_test.dart';
import 'package:comparador_de_precos/features/admin/admin_loja_details/bloc/bloc.dart';

void main() {
  group('AdminLojaDetailsState', () {
    test('supports value equality', () {
      expect(
        AdminLojaDetailsState(),
        equals(
          const AdminLojaDetailsState(),
        ),
      );
    });

    group('constructor', () {
      test('can be instantiated', () {
        expect(
          const AdminLojaDetailsState(),
          isNotNull,
        );
      });
    });

    group('copyWith', () {
      test(
        'copies correctly '
        'when no argument specified',
        () {
          const adminLojaDetailsState = AdminLojaDetailsState(
            customProperty: 'My property',
          );
          expect(
            adminLojaDetailsState.copyWith(),
            equals(adminLojaDetailsState),
          );
        },
      );

      test(
        'copies correctly '
        'when all arguments specified',
        () {
          const adminLojaDetailsState = AdminLojaDetailsState(
            customProperty: 'My property',
          );
          final otherAdminLojaDetailsState = AdminLojaDetailsState(
            customProperty: 'My property 2',
          );
          expect(adminLojaDetailsState, isNot(equals(otherAdminLojaDetailsState)));

          expect(
            adminLojaDetailsState.copyWith(
              customProperty: otherAdminLojaDetailsState.customProperty,
            ),
            equals(otherAdminLojaDetailsState),
          );
        },
      );
    });
  });
}
