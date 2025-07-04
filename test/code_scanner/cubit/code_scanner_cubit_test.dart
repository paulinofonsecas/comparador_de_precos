// ignore_for_file: prefer_const_constructors

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:comparador_de_precos/features/consumer/code_scanner/cubit/cubit.dart';

void main() {
  group('CodeScannerCubit', () {
    group('constructor', () {
      test('can be instantiated', () {
        expect(
          CodeScannerCubit(),
          isNotNull,
        );
      });
    });

    test('initial state has default value for customProperty', () {
      final codeScannerCubit = CodeScannerCubit();
      expect(codeScannerCubit.state.customProperty, equals('Default Value'));
    });

    blocTest<CodeScannerCubit, CodeScannerState>(
      'yourCustomFunction emits nothing',
      build: CodeScannerCubit.new,
      act: (cubit) => cubit.yourCustomFunction(),
      expect: () => <CodeScannerState>[],
    );
  });
}
