// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:comparador_de_precos/features/admin/admin_solicitacoes_lojas/admin_solicitacoes_lojas.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AdminSolicitacoesLojasPage', () {
    group('route', () {
      test('is routable', () {
        expect(AdminSolicitacoesLojasPage.route(), isA<MaterialPageRoute>());
      });
    });

    testWidgets('renders AdminSolicitacoesLojasView', (tester) async {
      await tester.pumpWidget(MaterialApp(home: AdminSolicitacoesLojasPage()));
      expect(find.byType(AdminSolicitacoesLojasView), findsOneWidget);
    });
  });
}
