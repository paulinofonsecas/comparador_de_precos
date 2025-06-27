// ignore_for_file: prefer_const_constructors

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:comparador_de_precos/features/admin/admin_loja_details/bloc/bloc.dart';

void main() {
  group('AdminLojaDetailsBloc', () {
    group('constructor', () {
      test('can be instantiated', () {
        expect(
          AdminLojaDetailsBloc(),
          isNotNull,
        );
      });
    });

    test('initial state has default value for customProperty', () {
      final adminLojaDetailsBloc = AdminLojaDetailsBloc();
      expect(adminLojaDetailsBloc.state.customProperty, equals('Default Value'));
    });

    blocTest<AdminLojaDetailsBloc, AdminLojaDetailsState>(
      'CustomAdminLojaDetailsEvent emits nothing',
      build: AdminLojaDetailsBloc.new,
      act: (bloc) => bloc.add(const CustomAdminLojaDetailsEvent()),
      expect: () => <AdminLojaDetailsState>[],
    );
  });
}
