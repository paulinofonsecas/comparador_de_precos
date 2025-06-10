// ignore_for_file: prefer_const_constructors

import 'package:flutter_test/flutter_test.dart';
import 'package:comparador_de_precos/features/logista/logista_dashboard/bloc/bloc.dart';

void main() {
  group('LogistaDashboardState', () {
    test('supports value equality', () {
      expect(
        LogistaDashboardState(),
        equals(
          const LogistaDashboardState(),
        ),
      );
    });

    group('constructor', () {
      test('can be instantiated', () {
        expect(
          const LogistaDashboardState(),
          isNotNull,
        );
      });
    });

    group('copyWith', () {
      test(
        'copies correctly '
        'when no argument specified',
        () {
          const logistaDashboardState = LogistaDashboardState(
            customProperty: 'My property',
          );
          expect(
            logistaDashboardState.copyWith(),
            equals(logistaDashboardState),
          );
        },
      );

      test(
        'copies correctly '
        'when all arguments specified',
        () {
          const logistaDashboardState = LogistaDashboardState(
            customProperty: 'My property',
          );
          final otherLogistaDashboardState = LogistaDashboardState(
            customProperty: 'My property 2',
          );
          expect(logistaDashboardState, isNot(equals(otherLogistaDashboardState)));

          expect(
            logistaDashboardState.copyWith(
              customProperty: otherLogistaDashboardState.customProperty,
            ),
            equals(otherLogistaDashboardState),
          );
        },
      );
    });
  });
}
