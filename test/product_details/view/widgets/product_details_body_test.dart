// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:comparador_de_precos/features/consumer/product_details/product_details.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ProductDetailsBody', () {
    testWidgets('renders Text', (tester) async { 
      await tester.pumpWidget(
        BlocProvider(
          create: (context) => ProductDetailsBloc(),
          child: MaterialApp(home: ProductDetailsBody()),
        ),
      );

      expect(find.byType(Text), findsOneWidget);
    });
  });
}
