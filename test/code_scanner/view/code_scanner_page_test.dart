// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:comparador_de_precos/features/consumer/code_scanner/code_scanner.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('CodeScannerPage', () {
    group('route', () {
      test('is routable', () {
        expect(CodeScannerPage.route(), isA<MaterialPageRoute>());
      });
    });

    testWidgets('renders CodeScannerView', (tester) async {
      await tester.pumpWidget(MaterialApp(home: CodeScannerPage()));
      expect(find.byType(CodeScannerView), findsOneWidget);
    });
  });
}
