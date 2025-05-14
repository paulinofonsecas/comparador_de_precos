import 'package:comparador_de_precos/data/repositories/authentication_repository.dart';
import 'package:comparador_de_precos/features/auth/bloc/auth_bloc.dart';
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
}

void setupBlocs() {
  getIt.registerSingleton<AuthBloc>(AuthBloc());
}
