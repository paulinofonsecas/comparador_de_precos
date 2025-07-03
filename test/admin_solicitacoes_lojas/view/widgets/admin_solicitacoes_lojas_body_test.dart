// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:comparador_de_precos/features/admin/admin_solicitacoes_lojas/admin_solicitacoes_lojas.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AdminSolicitacoesLojasBody', () {
    testWidgets('renders Text', (tester) async { 
      await tester.pumpWidget(
        BlocProvider(
          create: (context) => AdminSolicitacoesLojasBloc(),
          child: MaterialApp(home: AdminSolicitacoesLojasBody()),
        ),
      );

      expect(find.byType(Text), findsOneWidget);
    });
  });
}
