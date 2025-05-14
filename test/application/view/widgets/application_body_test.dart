// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:comparador_de_precos/features/client/application/application.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ApplicationBody', () {
    testWidgets('renders Text', (tester) async { 
      await tester.pumpWidget(
        BlocProvider(
          create: (context) => ApplicationBloc(),
          child: MaterialApp(home: ApplicationBody()),
        ),
      );

      expect(find.byType(Text), findsOneWidget);
    });
  });
}
