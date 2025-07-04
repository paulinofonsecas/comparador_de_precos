// ignore_for_file: prefer_const_constructors

import 'package:flutter_test/flutter_test.dart';
import 'package:comparador_de_precos/features/consumer/code_scanner/cubit/cubit.dart';

void main() {
  group('CodeScannerState', () {
    test('supports value equality', () {
      expect(
        CodeScannerState(),
        equals(
          const CodeScannerState(),
        ),
      );
    });

    group('constructor', () {
      test('can be instantiated', () {
        expect(
          const CodeScannerState(),
          isNotNull,
        );
      });
    });

    group('copyWith', () {
      test(
        'copies correctly '
        'when no argument specified',
        () {
          const codeScannerState = CodeScannerState(
            customProperty: 'My property',
          );
          expect(
            codeScannerState.copyWith(),
            equals(codeScannerState),
          );
        },
      );

      test(
        'copies correctly '
        'when all arguments specified',
        () {
          const codeScannerState = CodeScannerState(
            customProperty: 'My property',
          );
          final otherCodeScannerState = CodeScannerState(
            customProperty: 'My property 2',
          );
          expect(codeScannerState, isNot(equals(otherCodeScannerState)));

          expect(
            codeScannerState.copyWith(
              customProperty: otherCodeScannerState.customProperty,
            ),
            equals(otherCodeScannerState),
          );
        },
      );
    });
  });
}
