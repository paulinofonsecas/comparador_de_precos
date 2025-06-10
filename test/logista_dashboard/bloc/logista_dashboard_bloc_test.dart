// ignore_for_file: prefer_const_constructors

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:comparador_de_precos/features/logista/logista_dashboard/bloc/bloc.dart';

void main() {
  group('LogistaDashboardBloc', () {
    group('constructor', () {
      test('can be instantiated', () {
        expect(
          LogistaDashboardBloc(),
          isNotNull,
        );
      });
    });

    test('initial state has default value for customProperty', () {
      final logistaDashboardBloc = LogistaDashboardBloc();
      expect(logistaDashboardBloc.state.customProperty, equals('Default Value'));
    });

    blocTest<LogistaDashboardBloc, LogistaDashboardState>(
      'CustomLogistaDashboardEvent emits nothing',
      build: LogistaDashboardBloc.new,
      act: (bloc) => bloc.add(const CustomLogistaDashboardEvent()),
      expect: () => <LogistaDashboardState>[],
    );
  });
}
