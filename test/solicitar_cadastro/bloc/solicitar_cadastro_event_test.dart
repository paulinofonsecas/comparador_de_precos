// ignore_for_file: prefer_const_constructors

import 'package:flutter_test/flutter_test.dart';
import 'package:comparador_de_precos/features/logista/solicitar_cadastro/bloc/bloc.dart';

void main() {
  group('SolicitarCadastroEvent', () {  
    group('CustomSolicitarCadastroEvent', () {
      test('supports value equality', () {
        expect(
          CustomSolicitarCadastroEvent(),
          equals(const CustomSolicitarCadastroEvent()),
        );
      });
    });
    group('constructor', () {
      test('can be instantiated', () {
        expect(
          const CustomSolicitarCadastroEvent(),
          isNotNull
        );
      });
    });
  });
}
