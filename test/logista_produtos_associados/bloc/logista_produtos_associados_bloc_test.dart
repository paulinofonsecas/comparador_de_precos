// ignore_for_file: prefer_const_constructors

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:comparador_de_precos/features/logista/logista_produtos_associados/bloc/bloc.dart';

void main() {
  group('LogistaProdutosAssociadosBloc', () {
    group('constructor', () {
      test('can be instantiated', () {
        expect(
          LogistaProdutosAssociadosBloc(),
          isNotNull,
        );
      });
    });

    test('initial state has default value for customProperty', () {
      final logistaProdutosAssociadosBloc = LogistaProdutosAssociadosBloc();
      expect(logistaProdutosAssociadosBloc.state.customProperty, equals('Default Value'));
    });

    blocTest<LogistaProdutosAssociadosBloc, LogistaProdutosAssociadosState>(
      'CustomLogistaProdutosAssociadosEvent emits nothing',
      build: LogistaProdutosAssociadosBloc.new,
      act: (bloc) => bloc.add(const CustomLogistaProdutosAssociadosEvent()),
      expect: () => <LogistaProdutosAssociadosState>[],
    );
  });
}
