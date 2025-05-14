// ignore_for_file: prefer_const_constructors

import 'package:flutter_test/flutter_test.dart';
import 'package:comparador_de_precos/features/client/application/bloc/bloc.dart';

void main() {
  group('ApplicationEvent', () {  
    group('CustomApplicationEvent', () {
      test('supports value equality', () {
        expect(
          CustomApplicationEvent(),
          equals(const CustomApplicationEvent()),
        );
      });
    });
    group('constructor', () {
      test('can be instantiated', () {
        expect(
          const CustomApplicationEvent(),
          isNotNull
        );
      });
    });
  });
}
