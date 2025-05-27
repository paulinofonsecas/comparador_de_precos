// ignore_for_file: prefer_const_constructors

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:comparador_de_precos/features/consumer/product_details/bloc/bloc.dart';

void main() {
  group('ProductDetailsBloc', () {
    group('constructor', () {
      test('can be instantiated', () {
        expect(
          ProductDetailsBloc(),
          isNotNull,
        );
      });
    });

    test('initial state has default value for customProperty', () {
      final productDetailsBloc = ProductDetailsBloc();
      expect(productDetailsBloc.state.customProperty, equals('Default Value'));
    });

    blocTest<ProductDetailsBloc, ProductDetailsState>(
      'CustomProductDetailsEvent emits nothing',
      build: ProductDetailsBloc.new,
      act: (bloc) => bloc.add(const CustomProductDetailsEvent()),
      expect: () => <ProductDetailsState>[],
    );
  });
}
