// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:comparador_de_precos/features/admin/solicitaã§ãµes_lojas/solicitaã§ãµes_lojas.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Solicitaã§ãµesLojasBody', () {
    testWidgets('renders Text', (tester) async { 
      await tester.pumpWidget(
        BlocProvider(
          create: (context) => Solicitaã§ãµesLojasBloc(),
          child: MaterialApp(home: Solicitaã§ãµesLojasBody()),
        ),
      );

      expect(find.byType(Text), findsOneWidget);
    });
  });
}
