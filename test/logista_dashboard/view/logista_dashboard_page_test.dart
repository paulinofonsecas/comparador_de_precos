// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:comparador_de_precos/features/logista/logista_dashboard/logista_dashboard.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('LogistaDashboardPage', () {
    group('route', () {
      test('is routable', () {
        expect(LogistaDashboardPage.route(), isA<MaterialPageRoute>());
      });
    });

    testWidgets('renders LogistaDashboardView', (tester) async {
      await tester.pumpWidget(MaterialApp(home: LogistaDashboardPage()));
      expect(find.byType(LogistaDashboardView), findsOneWidget);
    });
  });
}
