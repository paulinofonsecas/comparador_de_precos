// ignore_for_file: prefer_const_constructors

import 'package:flutter_test/flutter_test.dart';
import 'package:comparador_de_precos/features/admin/admin_gestao_lojas/bloc/bloc.dart';

void main() {
  group('AdminGestaoLojasEvent', () {  
    group('CustomAdminGestaoLojasEvent', () {
      test('supports value equality', () {
        expect(
          CustomAdminGestaoLojasEvent(),
          equals(const CustomAdminGestaoLojasEvent()),
        );
      });
    });
    group('constructor', () {
      test('can be instantiated', () {
        expect(
          const CustomAdminGestaoLojasEvent(),
          isNotNull
        );
      });
    });
  });
}
