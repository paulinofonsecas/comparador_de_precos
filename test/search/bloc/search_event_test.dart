// ignore_for_file: prefer_const_constructors

import 'package:flutter_test/flutter_test.dart';
import 'package:comparador_de_precos/features/consumer/search/bloc/bloc.dart';

void main() {
  group('SearchEvent', () {  
    group('CustomSearchEvent', () {
      test('supports value equality', () {
        expect(
          CustomSearchEvent(),
          equals(const CustomSearchEvent()),
        );
      });
    });
    group('constructor', () {
      test('can be instantiated', () {
        expect(
          const CustomSearchEvent(),
          isNotNull
        );
      });
    });
  });
}
