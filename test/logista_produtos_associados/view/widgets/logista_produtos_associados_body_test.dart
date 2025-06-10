// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:comparador_de_precos/features/logista/logista_produtos_associados/logista_produtos_associados.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('LogistaProdutosAssociadosBody', () {
    testWidgets('renders Text', (tester) async { 
      await tester.pumpWidget(
        BlocProvider(
          create: (context) => LogistaProdutosAssociadosBloc(),
          child: MaterialApp(home: LogistaProdutosAssociadosBody()),
        ),
      );

      expect(find.byType(Text), findsOneWidget);
    });
  });
}
