import 'package:bloc_test/bloc_test.dart';
import 'package:comparador_de_precos/data/models/loja.dart';
import 'package:comparador_de_precos/data/repositories/loja_repository.dart';
import 'package:comparador_de_precos/features/consumer/loja_details/cubit/loja_details_cubit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockLojaRepository extends Mock implements LojaRepository {}

class MockLoja extends Mock implements Loja {}

void main() {
  late MockLojaRepository mockLojaRepository;
  late LojaDetailsCubit lojaDetailsCubit;
  late Loja mockLoja;

  setUp(() {
    mockLojaRepository = MockLojaRepository();
    lojaDetailsCubit = LojaDetailsCubit(mockLojaRepository);
    mockLoja = MockLoja();

    // Stubbing default behavior for mockLoja if needed for all tests
    when(() => mockLoja.id).thenReturn('test_loja_id');
    when(() => mockLoja.nome).thenReturn('Test Loja');
  });

  tearDown(() {
    lojaDetailsCubit.close();
  });

  test('initial state is LojaDetailsInitial', () {
    expect(lojaDetailsCubit.state, LojaDetailsInitial());
  });

  group('fetchLojaDetails', () {
    blocTest<LojaDetailsCubit, LojaDetailsState>(
      'emits [LojaDetailsLoading, LojaDetailsSuccess] when fetchLojaDetails is successful',
      setUp: () {
        when(() => mockLojaRepository.getLojaById(any()))
            .thenAnswer((_) async => mockLoja);
      },
      build: () => lojaDetailsCubit,
      act: (cubit) => cubit.fetchLojaDetails('test_loja_id'),
      expect: () => [
        LojaDetailsLoading(),
        LojaDetailsSuccess(mockLoja),
      ],
      verify: (_) {
        verify(() => mockLojaRepository.getLojaById('test_loja_id')).called(1);
      },
    );

    blocTest<LojaDetailsCubit, LojaDetailsState>(
      'emits [LojaDetailsLoading, LojaDetailsFailure] when getLojaById returns null',
      setUp: () {
        when(() => mockLojaRepository.getLojaById(any()))
            .thenAnswer((_) async => null);
      },
      build: () => lojaDetailsCubit,
      act: (cubit) => cubit.fetchLojaDetails('unknown_id'),
      expect: () => [
        LojaDetailsLoading(),
        const LojaDetailsFailure('Loja não encontrada'),
      ],
      verify: (_) {
        verify(() => mockLojaRepository.getLojaById('unknown_id')).called(1);
      },
    );

    blocTest<LojaDetailsCubit, LojaDetailsState>(
      'emits [LojaDetailsLoading, LojaDetailsFailure] when getLojaById throws an exception',
      setUp: () {
        when(() => mockLojaRepository.getLojaById(any()))
            .thenThrow(Exception('Test Exception'));
      },
      build: () => lojaDetailsCubit,
      act: (cubit) => cubit.fetchLojaDetails('test_loja_id'),
      expect: () => [
        LojaDetailsLoading(),
        const LojaDetailsFailure('Exception: Test Exception'),
      ],
      verify: (_) {
        verify(() => mockLojaRepository.getLojaById('test_loja_id')).called(1);
      },
    );
  });
}
