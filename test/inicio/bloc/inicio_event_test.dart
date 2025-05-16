// ignore_for_file: prefer_const_constructors

import 'package:flutter_test/flutter_test.dart';
import 'package:comparador_de_precos/features/client/inicio/bloc/bloc.dart';

void main() {
  group('InicioEvent', () {  
    group('CustomInicioEvent', () {
      test('supports value equality', () {
        expect(
          CustomInicioEvent(),
          equals(const CustomInicioEvent()),
        );
      });
    });
    group('constructor', () {
      test('can be instantiated', () {
        expect(
          const CustomInicioEvent(),
          isNotNull
        );
      });
    });
  });
}
