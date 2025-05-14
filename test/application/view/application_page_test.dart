// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:comparador_de_precos/features/client/application/application.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ApplicationPage', () {
    group('route', () {
      test('is routable', () {
        expect(ApplicationPage.route(), isA<MaterialPageRoute>());
      });
    });

    testWidgets('renders ApplicationView', (tester) async {
      await tester.pumpWidget(MaterialApp(home: ApplicationPage()));
      expect(find.byType(ApplicationView), findsOneWidget);
    });
  });
}
