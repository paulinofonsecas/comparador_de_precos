// ignore_for_file: prefer_const_constructors

import 'package:flutter_test/flutter_test.dart';
import 'package:comparador_de_precos/features/client/application/bloc/bloc.dart';

void main() {
  group('ApplicationState', () {
    test('supports value equality', () {
      expect(
        ApplicationState(),
        equals(
          const ApplicationState(),
        ),
      );
    });

    group('constructor', () {
      test('can be instantiated', () {
        expect(
          const ApplicationState(),
          isNotNull,
        );
      });
    });

    group('copyWith', () {
      test(
        'copies correctly '
        'when no argument specified',
        () {
          const applicationState = ApplicationState(
            customProperty: 'My property',
          );
          expect(
            applicationState.copyWith(),
            equals(applicationState),
          );
        },
      );

      test(
        'copies correctly '
        'when all arguments specified',
        () {
          const applicationState = ApplicationState(
            customProperty: 'My property',
          );
          final otherApplicationState = ApplicationState(
            customProperty: 'My property 2',
          );
          expect(applicationState, isNot(equals(otherApplicationState)));

          expect(
            applicationState.copyWith(
              customProperty: otherApplicationState.customProperty,
            ),
            equals(otherApplicationState),
          );
        },
      );
    });
  });
}
