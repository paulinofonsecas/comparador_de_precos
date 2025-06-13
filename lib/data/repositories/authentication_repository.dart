import 'package:comparador_de_precos/app/config/dependencies.dart';
import 'package:comparador_de_precos/app/params/new_user_form_param.dart';
import 'package:comparador_de_precos/data/models/my_user.dart';
import 'package:comparador_de_precos/data/models/user_profile.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class AuthenticationRepository {
  Future<MyUser> signInWithEmailAndPassword(String email, String password);
  Future<void> signOut();
  Future<MyUser> signUpWithEmailAndPassword(
    NewUserFormParam newUserFormParam,
  );
  Future<void> sendPasswordResetEmail(String email);
  Future<void> verifyEmail();
  Future<UserProfile?> getLogistaProfile(String userId);

  Future<MyUser?> getUser(String token);
}

class AuthenticationRepositoryImpl implements AuthenticationRepository {
  AuthenticationRepositoryImpl({
    required this.supabaseClient,
    required this.connectivity,
  });

  final SupabaseClient supabaseClient;
  final Connectivity connectivity;

  @override
  Future<void> sendPasswordResetEmail(String email) {
    // TODO: implement sendPasswordResetEmail
    throw UnimplementedError();
  }

  @override
  Future<MyUser> signInWithEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
      // Check if the device is connected to the internet
      final connectivityResult = await connectivity.checkConnectivity();
      if (connectivityResult.contains(ConnectivityResult.none)) {
        throw Exception('No internet connection');
      }

      final authResponse = await supabaseClient.auth.signInWithPassword(
        email: email,
        password: password,
      );

      final token = authResponse.session?.refreshToken;
      await saveToken(token);

      if (token == null) {
        throw Exception('Token not found');
      }

      if (authResponse.user == null) {
        throw Exception('User not found');
      }

      final profile = await getLogistaProfile(authResponse.user!.id);

      if (profile == null) {
        throw Exception('User not found');
      }

      return MyUser(
        id: authResponse.user!.id,
        email: authResponse.user!.email!,
        displayName: profile.nomeCompleto ?? '',
        photoURL: '',
        userType: profile.tipoUsuario.name,
      );
    } on Exception catch (e) {
      throw Exception('Ocorreu um erro desconhecido, tente novamente., $e');
    }
  }

  @override
  Future<void> signOut() async {
    try {
      // Check if the device is connected to the internet
      final connectivityResult = await connectivity.checkConnectivity();
      if (connectivityResult.contains(ConnectivityResult.none)) {
        throw Exception('No internet connection');
      }

      await supabaseClient.auth.signOut();
    } catch (e) {
      throw Exception('Failed to sign out: $e');
    }
  }

  @override
  Future<MyUser> signUpWithEmailAndPassword(
    NewUserFormParam newUserFormParam,
  ) async {
    try {
      // Check if the device is connected to the internet
      final connectivityResult = await connectivity.checkConnectivity();
      if (connectivityResult.contains(ConnectivityResult.none)) {
        throw Exception('No internet connection');
      }

      final authResponse = await supabaseClient.auth.signUp(
        email: newUserFormParam.email,
        password: newUserFormParam.senha,
        data: {
          'name': newUserFormParam.name,
          'avatar_url': '',
          'user_type': UserType.consumidor.name,
        },
      );

      if (authResponse.user == null) {
        throw Exception('User not found');
      }

      // gravar as informacoes na tabela profiles
      await supabaseClient.from('profiles').insert({
        'user_id': authResponse.user!.id,
        'nome_completo': newUserFormParam.name,
        'bi': newUserFormParam.bi,
        'tipo_usuario': UserType.consumidor.name,
        'telefone': newUserFormParam.telefone,
      });

      return MyUser(
        id: authResponse.user!.id,
        email: authResponse.user!.email!,
        displayName: authResponse.user!.userMetadata!['name'] as String?,
        photoURL: authResponse.user!.userMetadata!['avatar_url'] as String?,
        userType: authResponse.user!.userMetadata!['user_type'] as String?,
      );
    } on Exception catch (e) {
      throw Exception('Ocorreu um erro desconhecido, tente novamente. $e');
    }
  }

  @override
  Future<void> verifyEmail() {
    // TODO: implement verifyEmail
    throw UnimplementedError();
  }

  @override
  Future<UserProfile?> getLogistaProfile(String userId) async {
    try {
      // Check if the device is connected to the internet
      final profile = await supabaseClient
          .from('profiles')
          .select()
          .eq('user_id', userId)
          .limit(1)
          .maybeSingle();

      if (profile == null) {
        return null;
      }

      final userProfile = UserProfile.fromMap(profile);

      if (getIt.isRegistered<UserProfile>()) getIt.unregister<UserProfile>();

      getIt.registerLazySingleton(() => userProfile);

      return UserProfile.fromMap(profile);
    } catch (e) {
      throw Exception('Erro ao obter o perfil do usuário: $e');
    }
  }

  @override
  Future<MyUser?> getUser(String token) async {
    try {
      final newSession = await supabaseClient.auth.refreshSession(token);

      // Check if the device is connected to the internet)
      final user = await supabaseClient.auth.getUser();

      if (user.user == null) {
        return null;
      }

      final token2 = newSession.session?.refreshToken;
      await saveToken(token2);

      final profile = await getLogistaProfile(user.user!.id);

      if (profile == null) {
        return null;
      }

      return MyUser(
        id: user.user!.id,
        email: user.user!.email!,
        displayName: profile.nomeCompleto,
        photoURL: '',
        userType: profile.tipoUsuario.name,
      );
    } catch (e) {
      throw Exception('Erro ao obter o usuário: $e');
    }
  }

  Future<void> saveToken(String? token) async {
    final prefs = getIt<SharedPreferences>();
    await prefs.setString('token', token!);
  }
}
