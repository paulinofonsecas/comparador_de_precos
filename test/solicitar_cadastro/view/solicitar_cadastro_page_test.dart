// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:comparador_de_precos/features/logista/solicitar_cadastro/solicitar_cadastro.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('SolicitarCadastroPage', () {
    group('route', () {
      test('is routable', () {
        expect(SolicitarCadastroPage.route(), isA<MaterialPageRoute>());
      });
    });

    testWidgets('renders SolicitarCadastroView', (tester) async {
      await tester.pumpWidget(MaterialApp(home: SolicitarCadastroPage()));
      expect(find.byType(SolicitarCadastroView), findsOneWidget);
    });
  });
}
