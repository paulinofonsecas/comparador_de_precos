// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:comparador_de_precos/features/admin/admin_gestao_lojas/admin_gestao_lojas.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AdminGestaoLojasBody', () {
    testWidgets('renders Text', (tester) async { 
      await tester.pumpWidget(
        BlocProvider(
          create: (context) => AdminGestaoLojasBloc(),
          child: MaterialApp(home: AdminGestaoLojasBody()),
        ),
      );

      expect(find.byType(Text), findsOneWidget);
    });
  });
}
