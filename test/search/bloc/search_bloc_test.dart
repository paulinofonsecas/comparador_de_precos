// ignore_for_file: prefer_const_constructors

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:comparador_de_precos/features/consumer/search/bloc/bloc.dart';

void main() {
  group('SearchBloc', () {
    group('constructor', () {
      test('can be instantiated', () {
        expect(
          SearchBloc(),
          isNotNull,
        );
      });
    });

    test('initial state has default value for customProperty', () {
      final searchBloc = SearchBloc();
      expect(searchBloc.state.customProperty, equals('Default Value'));
    });

    blocTest<SearchBloc, SearchState>(
      'CustomSearchEvent emits nothing',
      build: SearchBloc.new,
      act: (bloc) => bloc.add(const CustomSearchEvent()),
      expect: () => <SearchState>[],
    );
  });
}
