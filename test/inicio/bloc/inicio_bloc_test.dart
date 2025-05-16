// ignore_for_file: prefer_const_constructors

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:comparador_de_precos/features/client/inicio/bloc/bloc.dart';

void main() {
  group('InicioBloc', () {
    group('constructor', () {
      test('can be instantiated', () {
        expect(
          InicioBloc(),
          isNotNull,
        );
      });
    });

    test('initial state has default value for customProperty', () {
      final inicioBloc = InicioBloc();
      expect(inicioBloc.state.customProperty, equals('Default Value'));
    });

    blocTest<InicioBloc, InicioState>(
      'CustomInicioEvent emits nothing',
      build: InicioBloc.new,
      act: (bloc) => bloc.add(const CustomInicioEvent()),
      expect: () => <InicioState>[],
    );
  });
}
