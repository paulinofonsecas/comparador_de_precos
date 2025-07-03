// ignore_for_file: prefer_const_constructors

import 'package:flutter_test/flutter_test.dart';
import 'package:comparador_de_precos/features/admin/solicitaã§ãµes_lojas/bloc/bloc.dart';

void main() {
  group('Solicitaã§ãµesLojasEvent', () {  
    group('CustomSolicitaã§ãµesLojasEvent', () {
      test('supports value equality', () {
        expect(
          CustomSolicitaã§ãµesLojasEvent(),
          equals(const CustomSolicitaã§ãµesLojasEvent()),
        );
      });
    });
    group('constructor', () {
      test('can be instantiated', () {
        expect(
          const CustomSolicitaã§ãµesLojasEvent(),
          isNotNull
        );
      });
    });
  });
}
