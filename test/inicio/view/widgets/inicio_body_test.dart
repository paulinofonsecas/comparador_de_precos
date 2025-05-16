// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:comparador_de_precos/features/client/inicio/inicio.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('InicioBody', () {
    testWidgets('renders Text', (tester) async { 
      await tester.pumpWidget(
        BlocProvider(
          create: (context) => InicioBloc(),
          child: MaterialApp(home: InicioBody()),
        ),
      );

      expect(find.byType(Text), findsOneWidget);
    });
  });
}
