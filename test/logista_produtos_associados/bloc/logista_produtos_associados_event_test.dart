// ignore_for_file: prefer_const_constructors

import 'package:flutter_test/flutter_test.dart';
import 'package:comparador_de_precos/features/logista/logista_produtos_associados/bloc/bloc.dart';

void main() {
  group('LogistaProdutosAssociadosEvent', () {  
    group('CustomLogistaProdutosAssociadosEvent', () {
      test('supports value equality', () {
        expect(
          CustomLogistaProdutosAssociadosEvent(),
          equals(const CustomLogistaProdutosAssociadosEvent()),
        );
      });
    });
    group('constructor', () {
      test('can be instantiated', () {
        expect(
          const CustomLogistaProdutosAssociadosEvent(),
          isNotNull
        );
      });
    });
  });
}
