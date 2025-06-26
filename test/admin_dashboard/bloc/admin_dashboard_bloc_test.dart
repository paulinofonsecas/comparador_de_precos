// ignore_for_file: prefer_const_constructors

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:comparador_de_precos/features/admin/admin_dashboard/bloc/bloc.dart';

void main() {
  group('AdminDashboardBloc', () {
    group('constructor', () {
      test('can be instantiated', () {
        expect(
          AdminDashboardBloc(),
          isNotNull,
        );
      });
    });

    test('initial state has default value for customProperty', () {
      final adminDashboardBloc = AdminDashboardBloc();
      expect(adminDashboardBloc.state.customProperty, equals('Default Value'));
    });

    blocTest<AdminDashboardBloc, AdminDashboardState>(
      'CustomAdminDashboardEvent emits nothing',
      build: AdminDashboardBloc.new,
      act: (bloc) => bloc.add(const CustomAdminDashboardEvent()),
      expect: () => <AdminDashboardState>[],
    );
  });
}
