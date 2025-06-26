// ignore_for_file: prefer_const_constructors

import 'package:flutter_test/flutter_test.dart';
import 'package:comparador_de_precos/features/admin/admin_dashboard/bloc/bloc.dart';

void main() {
  group('AdminDashboardEvent', () {  
    group('CustomAdminDashboardEvent', () {
      test('supports value equality', () {
        expect(
          CustomAdminDashboardEvent(),
          equals(const CustomAdminDashboardEvent()),
        );
      });
    });
    group('constructor', () {
      test('can be instantiated', () {
        expect(
          const CustomAdminDashboardEvent(),
          isNotNull
        );
      });
    });
  });
}
