// ignore_for_file: prefer_const_constructors

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:comparador_de_precos/features/admin/admin_gestao_lojas/bloc/bloc.dart';

void main() {
  group('AdminGestaoLojasBloc', () {
    group('constructor', () {
      test('can be instantiated', () {
        expect(
          AdminGestaoLojasBloc(),
          isNotNull,
        );
      });
    });

    test('initial state has default value for customProperty', () {
      final adminGestaoLojasBloc = AdminGestaoLojasBloc();
      expect(adminGestaoLojasBloc.state.customProperty, equals('Default Value'));
    });

    blocTest<AdminGestaoLojasBloc, AdminGestaoLojasState>(
      'CustomAdminGestaoLojasEvent emits nothing',
      build: AdminGestaoLojasBloc.new,
      act: (bloc) => bloc.add(const CustomAdminGestaoLojasEvent()),
      expect: () => <AdminGestaoLojasState>[],
    );
  });
}
