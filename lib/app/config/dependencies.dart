import 'package:comparador_de_precos/data/repositories/authentication_repository.dart';
import 'package:comparador_de_precos/data/repositories/loja_repository.dart';
import 'package:comparador_de_precos/data/repositories/product_catalog_repository.dart';
import 'package:comparador_de_precos/data/repositories/search_repository.dart';
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
    );
}

void setupBlocs() {
  getIt
    ..registerLazySingleton<AuthBloc>(AuthBloc.new)
    ..registerLazySingleton<SignupBloc>(
      () => SignupBloc(getIt()),
    );
}
