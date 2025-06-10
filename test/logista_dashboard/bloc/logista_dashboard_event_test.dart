// ignore_for_file: prefer_const_constructors

import 'package:flutter_test/flutter_test.dart';
import 'package:comparador_de_precos/features/logista/logista_dashboard/bloc/bloc.dart';

void main() {
  group('LogistaDashboardEvent', () {  
    group('CustomLogistaDashboardEvent', () {
      test('supports value equality', () {
        expect(
          CustomLogistaDashboardEvent(),
          equals(const CustomLogistaDashboardEvent()),
        );
      });
    });
    group('constructor', () {
      test('can be instantiated', () {
        expect(
          const CustomLogistaDashboardEvent(),
          isNotNull
        );
      });
    });
  });
}
