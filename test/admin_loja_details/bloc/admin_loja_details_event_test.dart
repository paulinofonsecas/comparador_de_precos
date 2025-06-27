// ignore_for_file: prefer_const_constructors

import 'package:flutter_test/flutter_test.dart';
import 'package:comparador_de_precos/features/admin/admin_loja_details/bloc/bloc.dart';

void main() {
  group('AdminLojaDetailsEvent', () {  
    group('CustomAdminLojaDetailsEvent', () {
      test('supports value equality', () {
        expect(
          CustomAdminLojaDetailsEvent(),
          equals(const CustomAdminLojaDetailsEvent()),
        );
      });
    });
    group('constructor', () {
      test('can be instantiated', () {
        expect(
          const CustomAdminLojaDetailsEvent(),
          isNotNull
        );
      });
    });
  });
}
