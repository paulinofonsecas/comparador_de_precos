// ignore_for_file: prefer_const_constructors

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:comparador_de_precos/features/logista/solicitar_cadastro/bloc/bloc.dart';

void main() {
  group('SolicitarCadastroBloc', () {
    group('constructor', () {
      test('can be instantiated', () {
        expect(
          SolicitarCadastroBloc(),
          isNotNull,
        );
      });
    });

    test('initial state has default value for customProperty', () {
      final solicitarCadastroBloc = SolicitarCadastroBloc();
      expect(solicitarCadastroBloc.state.customProperty, equals('Default Value'));
    });

    blocTest<SolicitarCadastroBloc, SolicitarCadastroState>(
      'CustomSolicitarCadastroEvent emits nothing',
      build: SolicitarCadastroBloc.new,
      act: (bloc) => bloc.add(const CustomSolicitarCadastroEvent()),
      expect: () => <SolicitarCadastroState>[],
    );
  });
}
