// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:comparador_de_precos/features/client/inicio/inicio.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('InicioPage', () {
    group('route', () {
      test('is routable', () {
        expect(InicioPage.route(), isA<MaterialPageRoute>());
      });
    });

    testWidgets('renders InicioView', (tester) async {
      await tester.pumpWidget(MaterialApp(home: InicioPage()));
      expect(find.byType(InicioView), findsOneWidget);
    });
  });
}
