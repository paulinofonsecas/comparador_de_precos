// ignore_for_file: prefer_const_constructors

import 'package:flutter_test/flutter_test.dart';
import 'package:comparador_de_precos/features/admin/admin_solicitacoes_lojas/bloc/bloc.dart';

void main() {
  group('AdminSolicitacoesLojasEvent', () {  
    group('CustomAdminSolicitacoesLojasEvent', () {
      test('supports value equality', () {
        expect(
          CustomAdminSolicitacoesLojasEvent(),
          equals(const CustomAdminSolicitacoesLojasEvent()),
        );
      });
    });
    group('constructor', () {
      test('can be instantiated', () {
        expect(
          const CustomAdminSolicitacoesLojasEvent(),
          isNotNull
        );
      });
    });
  });
}
