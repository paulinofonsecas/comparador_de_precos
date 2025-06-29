import 'package:comparador_de_precos/data/repositories/authentication_repository.dart';
import 'package:comparador_de_precos/data/repositories/avaliacao_repository.dart';
import 'package:comparador_de_precos/data/repositories/lista_compra_repository.dart';
import 'package:comparador_de_precos/data/repositories/logista_repository.dart';
import 'package:comparador_de_precos/data/repositories/loja_repository.dart';
import 'package:comparador_de_precos/data/repositories/product_catalog_repository.dart';
import 'package:comparador_de_precos/data/repositories/search_repository.dart';
import 'package:comparador_de_precos/data/services/location_service.dart';
import 'package:comparador_de_precos/features/auth/bloc/auth_bloc.dart';
import 'package:comparador_de_precos/features/auth/signup/bloc/signup_bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final getIt = GetIt.instance;

Future<void> setupDependencies() async {
  final sp = await SharedPreferences.getInstance();
  getIt
    ..registerLazySingleton<SupabaseClient>(
      () => Supabase.instance.client,
    )
    ..registerLazySingleton<SharedPreferences>(() => sp)
    ..registerLazySingleton<Connectivity>(Connectivity.new)
    ..registerLazySingleton<AuthenticationRepository>(
      () => AuthenticationRepositoryImpl(
        connectivity: getIt<Connectivity>(),
        supabaseClient: getIt<SupabaseClient>(),
      ),
    );

  setupBlocs();
  setupRepositories();
}

void setupRepositories() {
  getIt
    ..registerLazySingleton<ProductCatalogRepository>(
      () => ProductCatalogRepository(
        supabaseClient: getIt<SupabaseClient>(),
      ),
    )
    ..registerLazySingleton<SearchProductRepository>(
      () => SearchProductRepository(
        supabaseClient: getIt<SupabaseClient>(),
      ),
    )
    ..registerLazySingleton<LojaRepository>(
      () => LojaRepository(
        supabaseClient: getIt<SupabaseClient>(),
      ),
    )
    ..registerLazySingleton<AvaliacaoRepository>(
      () => AvaliacaoRepository(
        getIt<SupabaseClient>(),
      ),
    )
    ..registerLazySingleton<LojistaRepository>(
      () => LojistaRepository(
        getIt<SupabaseClient>(),
      ),
    )
    ..registerLazySingleton<LocationService>(LocationService.new)
    ..registerLazySingleton<ILojistaRepository>(
      () => LojistaRepository(getIt()),
    )
    ..registerLazySingleton<ListaCompraRepository>(ListaCompraRepository.new);
}

void setupBlocs() {
  getIt
    ..registerLazySingleton<AuthBloc>(
      () => AuthBloc(
        authenticationRepository: getIt<AuthenticationRepository>(),
      ),
    )
    ..registerLazySingleton<SignupBloc>(
      () => SignupBloc(getIt()),
    );
}
