// ignore_for_file: lines_longer_than_80_chars

import 'package:bloc_test/bloc_test.dart';
import 'package:comparador_de_precos/data/models/loja.dart';
import 'package:comparador_de_precos/data/repositories/loja_repository.dart';
import 'package:comparador_de_precos/features/consumer/loja_details/cubit/loja_details_cubit.dart';
import 'package:comparador_de_precos/features/consumer/loja_details/view/loja_details_page.dart';
import 'package:comparador_de_precos/features/consumer/loja_details/widgets/loja_details_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

// Mocks
class MockLojaDetailsCubit extends MockCubit<LojaDetailsState>
    implements LojaDetailsCubit {}

class MockLojaRepository extends Mock
    implements LojaRepository {} // Needed if creating cubit directly

class MockLoja extends Mock implements Loja {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late LojaDetailsCubit mockLojaDetailsCubit;
  late Loja mockLoja;
  late MockLojaRepository mockLojaRepository; // For providing the repository

  setUpAll(() {
    registerFallbackValue(
      LojaDetailsInitial(),
    ); // For when a state is emitted by mock cubit
    registerFallbackValue(MockLoja()); // For Loja objects
  });

  setUp(() {
    mockLojaDetailsCubit = MockLojaDetailsCubit();
    mockLoja = MockLoja();
    mockLojaRepository = MockLojaRepository(); // Instantiate mock repository

    // Stub default Loja properties
    when(() => mockLoja.id).thenReturn('loja123');
    when(() => mockLoja.nome).thenReturn('Super Loja Teste');
    when(() => mockLoja.endereco).thenReturn('Rua Teste, 123');
    when(() => mockLoja.telefoneContato).thenReturn('99999-9999');

    // Stub cubit's initial state or fetchLojaDetails behavior if needed for all tests
    // For most widget tests, we'll control the state directly.
  });

  Widget createTestWidget(Widget child) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<LojaRepository>.value(value: mockLojaRepository),
      ],
      child: MaterialApp(
        home: BlocProvider<LojaDetailsCubit>.value(
          value: mockLojaDetailsCubit,
          child: child,
        ),
      ),
    );
  }

  // This version of createTestWidget is for when you want the actual cubit to run
  Widget createTestWidgetWithRealCubit(Widget child) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<LojaRepository>.value(value: mockLojaRepository),
      ],
      child: MaterialApp(
        home: child, // LojaDetailsPage will create its own BlocProvider
      ),
    );
  }

  testWidgets(
      'renders LojaDetailsPage and displays initial store name in AppBar',
      (tester) async {
    when(() => mockLojaDetailsCubit.state)
        .thenReturn(LojaDetailsInitial()); // Initial state
    // Or, if cubit fetches on init and we want to test that:
    // when(() => mockLojaRepository.getLojaById(any())).thenAnswer((_) async => mockLoja);
    // when(() => mockLojaDetailsCubit.state).thenReturn(LojaDetailsSuccess(mockLoja));

    await tester
        .pumpWidget(createTestWidget(LojaDetailsPage(lojaId: mockLoja.id)));

    // Verify AppBar title
    expect(find.widgetWithText(AppBar, 'Detalhes da Loja'), findsOneWidget);
  });

  testWidgets('renders LojaDetailsBody when cubit emits LojaDetailsSuccess',
      (tester) async {
    when(() => mockLojaDetailsCubit.state)
        .thenReturn(LojaDetailsSuccess(mockLoja));

    await tester
        .pumpWidget(createTestWidget(LojaDetailsPage(lojaId: mockLoja.id)));

    await tester.pumpAndSettle(const Duration(seconds: 1));

    // Verify LojaDetailsBody is present
    expect(find.byType(LojaDetailsBody), findsOneWidget);
    // Verify some content from LojaDetailsBody based on mockLoja
    expect(
      find.text('Super Loja Teste'),
      findsAtLeastNWidgets(1),
    ); // Name might be in AppBar and Body
    expect(find.text('Endereço: Rua Teste, 123'), findsOneWidget);
  });

  testWidgets('shows loading indicator when state is LojaDetailsLoading',
      (tester) async {
    // Ensure the cubit is configured to emit loading then success/failure
    // For this test, we directly set the state to loading.
    when(() => mockLojaDetailsCubit.state).thenReturn(LojaDetailsLoading());

    await tester
        .pumpWidget(createTestWidget(LojaDetailsPage(lojaId: mockLoja.id)));

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('shows error message when state is LojaDetailsFailure',
      (tester) async {
    when(() => mockLojaDetailsCubit.state)
        .thenReturn(const LojaDetailsFailure('Failed to load'));

    await tester
        .pumpWidget(createTestWidget(LojaDetailsPage(lojaId: mockLoja.id)));

    expect(find.text('Erro: Failed to load'), findsOneWidget);
  });

  // Test for the actual cubit interaction within LojaDetailsPage
  testWidgets(
      'LojaDetailsPage fetches details and displays them using its own Cubit',
      (tester) async {
    // Prepare the mock repository for the actual cubit
    when(() => mockLojaRepository.getLojaById('loja123')).thenAnswer((_) async {
      // Short delay to simulate network
      await Future.delayed(const Duration(milliseconds: 100));
      return mockLoja;
    });

    // Use createTestWidgetWithRealCubit as LojaDetailsPage creates its own BlocProvider
    await tester.pumpWidget(
      createTestWidgetWithRealCubit(LojaDetailsPage(lojaId: mockLoja.id)),
    );

    // Initial state might show basic info from widget.loja
    expect(find.widgetWithText(AppBar, 'Super Loja Teste'), findsOneWidget);
    // Might show initial body based on widget.loja
    expect(find.byType(LojaDetailsBody), findsOneWidget);
    expect(find.text('Super Loja Teste'), findsAtLeastNWidgets(1));

    // Expect loading state while cubit fetches
    // The way the page is structured, it might immediately show widget.loja data,
    // then transition if fetchLojaDetails is called in create.
    // If fetch is fast, loading might be skipped or too brief.
    // Let's pump to ensure any initial build is done.
    await tester.pump();

    // If fetchLojaDetails is called in create, it should move to loading
    // The BlocBuilder logic: `if (state is LojaDetailsLoading && state is! LojaDetailsSuccess)`
    // This means loading is shown only if no success state was previously achieved.
    // If the initial state is LojaDetailsInitial and fetch is called, it goes LojaDetailsLoading -> LojaDetailsSuccess

    // Pump for the loading state
    await tester.pump(
      Duration.zero,
    ); // Allow microtasks to complete (e.g. cubit emitting loading)
    // Depending on the BlocBuilder logic, a CircularProgressIndicator might appear
    // If the initial build already shows LojaDetailsBody with widget.loja, this might not find it.
    // The current page logic always shows LojaDetailsBody with widget.loja initially,
    // then updates if the cubit provides a new Loja object.

    // Pump through the fetch duration + little buffer
    await tester.pump(const Duration(milliseconds: 150));

    // After fetch, LojaDetailsSuccess state should be active
    // And LojaDetailsBody should be displayed with data from the cubit's state
    expect(find.byType(LojaDetailsBody), findsOneWidget);
    expect(find.text('Super Loja Teste'), findsAtLeastNWidgets(1));
    expect(find.text('Endereço: Rua Teste, 123'), findsOneWidget);
    expect(find.text('Telefone: 99999-9999'), findsOneWidget);

    verify(() => mockLojaRepository.getLojaById('loja123')).called(1);
  });

  // Navigation test should be in `oferta_details_body_test.dart`
  // Example of how it would look:
  // testWidgets('tapping LojaInfoSection navigates to LojaDetailsPage', (tester) async {
  //   // Setup OfertaDetailsPage with its dependencies and mocks
  //   // Ensure LojaInfoSection is rendered and receives a Loja object
  //   // ...
  //
  //   await tester.tap(find.byType(LojaInfoSection)); // Or a more specific finder
  //   await tester.pumpAndSettle(); // Wait for navigation animation
  //
  //   expect(find.byType(LojaDetailsPage), findsOneWidget);
  //   expect(find.widgetWithText(AppBar, 'Expected Loja Name From Navigation'), findsOneWidget);
  // });
}
