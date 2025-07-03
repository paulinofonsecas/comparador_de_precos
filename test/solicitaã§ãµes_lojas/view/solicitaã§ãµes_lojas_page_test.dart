// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:comparador_de_precos/features/admin/solicitaã§ãµes_lojas/solicitaã§ãµes_lojas.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Solicitaã§ãµesLojasPage', () {
    group('route', () {
      test('is routable', () {
        expect(Solicitaã§ãµesLojasPage.route(), isA<MaterialPageRoute>());
      });
    });

    testWidgets('renders Solicitaã§ãµesLojasView', (tester) async {
      await tester.pumpWidget(MaterialApp(home: Solicitaã§ãµesLojasPage()));
      expect(find.byType(Solicitaã§ãµesLojasView), findsOneWidget);
    });
  });
}
