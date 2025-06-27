// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:comparador_de_precos/features/admin/admin_loja_details/admin_loja_details.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AdminLojaDetailsPage', () {
    group('route', () {
      test('is routable', () {
        expect(AdminLojaDetailsPage.route(), isA<MaterialPageRoute>());
      });
    });

    testWidgets('renders AdminLojaDetailsView', (tester) async {
      await tester.pumpWidget(MaterialApp(home: AdminLojaDetailsPage()));
      expect(find.byType(AdminLojaDetailsView), findsOneWidget);
    });
  });
}
