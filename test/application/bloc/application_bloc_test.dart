// ignore_for_file: prefer_const_constructors

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:comparador_de_precos/features/client/application/bloc/bloc.dart';

void main() {
  group('ApplicationBloc', () {
    group('constructor', () {
      test('can be instantiated', () {
        expect(
          ApplicationBloc(),
          isNotNull,
        );
      });
    });

    test('initial state has default value for customProperty', () {
      final applicationBloc = ApplicationBloc();
      expect(applicationBloc.state.customProperty, equals('Default Value'));
    });

    blocTest<ApplicationBloc, ApplicationState>(
      'CustomApplicationEvent emits nothing',
      build: ApplicationBloc.new,
      act: (bloc) => bloc.add(const CustomApplicationEvent()),
      expect: () => <ApplicationState>[],
    );
  });
}
