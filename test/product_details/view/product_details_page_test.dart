// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:comparador_de_precos/features/consumer/product_details/product_details.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ProductDetailsPage', () {
    group('route', () {
      test('is routable', () {
        expect(ProductDetailsPage.route(), isA<MaterialPageRoute>());
      });
    });

    testWidgets('renders ProductDetailsView', (tester) async {
      await tester.pumpWidget(MaterialApp(home: ProductDetailsPage()));
      expect(find.byType(ProductDetailsView), findsOneWidget);
    });
  });
}
