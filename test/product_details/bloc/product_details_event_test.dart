// ignore_for_file: prefer_const_constructors

import 'package:flutter_test/flutter_test.dart';
import 'package:comparador_de_precos/features/consumer/product_details/bloc/bloc.dart';

void main() {
  group('ProductDetailsEvent', () {  
    group('CustomProductDetailsEvent', () {
      test('supports value equality', () {
        expect(
          CustomProductDetailsEvent(),
          equals(const CustomProductDetailsEvent()),
        );
      });
    });
    group('constructor', () {
      test('can be instantiated', () {
        expect(
          const CustomProductDetailsEvent(),
          isNotNull
        );
      });
    });
  });
}
