// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:comparador_de_precos/features/logista/logista_produtos_associados/logista_produtos_associados.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('LogistaProdutosAssociadosPage', () {
    group('route', () {
      test('is routable', () {
        expect(LogistaProdutosAssociadosPage.route(), isA<MaterialPageRoute>());
      });
    });

    testWidgets('renders LogistaProdutosAssociadosView', (tester) async {
      await tester.pumpWidget(MaterialApp(home: LogistaProdutosAssociadosPage()));
      expect(find.byType(LogistaProdutosAssociadosView), findsOneWidget);
    });
  });
}
