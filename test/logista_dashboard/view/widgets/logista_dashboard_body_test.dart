// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:comparador_de_precos/features/logista/logista_dashboard/logista_dashboard.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('LogistaDashboardBody', () {
    testWidgets('renders Text', (tester) async { 
      await tester.pumpWidget(
        BlocProvider(
          create: (context) => LogistaDashboardBloc(),
          child: MaterialApp(home: LogistaDashboardBody()),
        ),
      );

      expect(find.byType(Text), findsOneWidget);
    });
  });
}
