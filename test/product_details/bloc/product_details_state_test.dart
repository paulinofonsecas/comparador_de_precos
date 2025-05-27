// ignore_for_file: prefer_const_constructors

import 'package:flutter_test/flutter_test.dart';
import 'package:comparador_de_precos/features/consumer/product_details/bloc/bloc.dart';

void main() {
  group('ProductDetailsState', () {
    test('supports value equality', () {
      expect(
        ProductDetailsState(),
        equals(
          const ProductDetailsState(),
        ),
      );
    });

    group('constructor', () {
      test('can be instantiated', () {
        expect(
          const ProductDetailsState(),
          isNotNull,
        );
      });
    });

    group('copyWith', () {
      test(
        'copies correctly '
        'when no argument specified',
        () {
          const productDetailsState = ProductDetailsState(
            customProperty: 'My property',
          );
          expect(
            productDetailsState.copyWith(),
            equals(productDetailsState),
          );
        },
      );

      test(
        'copies correctly '
        'when all arguments specified',
        () {
          const productDetailsState = ProductDetailsState(
            customProperty: 'My property',
          );
          final otherProductDetailsState = ProductDetailsState(
            customProperty: 'My property 2',
          );
          expect(productDetailsState, isNot(equals(otherProductDetailsState)));

          expect(
            productDetailsState.copyWith(
              customProperty: otherProductDetailsState.customProperty,
            ),
            equals(otherProductDetailsState),
          );
        },
      );
    });
  });
}
