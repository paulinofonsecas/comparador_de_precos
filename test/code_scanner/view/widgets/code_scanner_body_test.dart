// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:comparador_de_precos/features/consumer/code_scanner/code_scanner.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('CodeScannerBody', () {
    testWidgets('renders Text', (tester) async { 
      await tester.pumpWidget(
        BlocProvider(
          create: (context) => CodeScannerCubit(),
          child: MaterialApp(home: CodeScannerBody()),
        ),
      );

      expect(find.byType(Text), findsOneWidget);
    });
  });
}
