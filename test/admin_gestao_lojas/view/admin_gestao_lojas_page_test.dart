// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:comparador_de_precos/features/admin/admin_gestao_lojas/admin_gestao_lojas.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AdminGestaoLojasPage', () {
    group('route', () {
      test('is routable', () {
        expect(AdminGestaoLojasPage.route(), isA<MaterialPageRoute>());
      });
    });

    testWidgets('renders AdminGestaoLojasView', (tester) async {
      await tester.pumpWidget(MaterialApp(home: AdminGestaoLojasPage()));
      expect(find.byType(AdminGestaoLojasView), findsOneWidget);
    });
  });
}
