// ignore_for_file: prefer_const_constructors

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:comparador_de_precos/features/admin/solicitaã§ãµes_lojas/bloc/bloc.dart';

void main() {
  group('Solicitaã§ãµesLojasBloc', () {
    group('constructor', () {
      test('can be instantiated', () {
        expect(
          Solicitaã§ãµesLojasBloc(),
          isNotNull,
        );
      });
    });

    test('initial state has default value for customProperty', () {
      final solicitaã§ãµesLojasBloc = Solicitaã§ãµesLojasBloc();
      expect(solicitaã§ãµesLojasBloc.state.customProperty, equals('Default Value'));
    });

    blocTest<Solicitaã§ãµesLojasBloc, Solicitaã§ãµesLojasState>(
      'CustomSolicitaã§ãµesLojasEvent emits nothing',
      build: Solicitaã§ãµesLojasBloc.new,
      act: (bloc) => bloc.add(const CustomSolicitaã§ãµesLojasEvent()),
      expect: () => <Solicitaã§ãµesLojasState>[],
    );
  });
}
