// ignore_for_file: prefer_const_constructors

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:comparador_de_precos/features/admin/admin_solicitacoes_lojas/bloc/bloc.dart';

void main() {
  group('AdminSolicitacoesLojasBloc', () {
    group('constructor', () {
      test('can be instantiated', () {
        expect(
          AdminSolicitacoesLojasBloc(),
          isNotNull,
        );
      });
    });

    test('initial state has default value for customProperty', () {
      final adminSolicitacoesLojasBloc = AdminSolicitacoesLojasBloc();
      expect(adminSolicitacoesLojasBloc.state.customProperty, equals('Default Value'));
    });

    blocTest<AdminSolicitacoesLojasBloc, AdminSolicitacoesLojasState>(
      'CustomAdminSolicitacoesLojasEvent emits nothing',
      build: AdminSolicitacoesLojasBloc.new,
      act: (bloc) => bloc.add(const CustomAdminSolicitacoesLojasEvent()),
      expect: () => <AdminSolicitacoesLojasState>[],
    );
  });
}
