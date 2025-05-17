import 'package:comparador_de_precos/app/params/new_user_form_param.dart';
import 'package:comparador_de_precos/data/models/my_user.dart';
import 'package:comparador_de_precos/data/models/user_profile.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class AuthenticationRepository {
  Future<MyUser> signInWithEmailAndPassword(String email, String password);
  Future<void> signOut();
  Future<MyUser> signUpWithEmailAndPassword(
    NewUserFormParam newUserFormParam,
  );
  Future<void> sendPasswordResetEmail(String email);
  Future<void> verifyEmail();
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

      if (authResponse.user == null) {
        throw Exception('User not found');
      }

      return MyUser(
        id: authResponse.user!.id,
        email: authResponse.user!.email!,
        displayName: authResponse.user!.userMetadata!['name'] as String?,
        photoURL: authResponse.user!.userMetadata!['avatar_url'] as String?,
        userType: authResponse.user!.userMetadata!['user_type'] as String?,
      );
    } on Exception catch (e) {
      throw Exception('Ocorreu um erro desconhecido, tente novamente., $e');
    }
  }

  @override
  Future<void> signOut() async {
    // try {
    //   // Check if the device is connected to the internet
    //   final connectivityResult = await connectivity.checkConnectivity();
    //   if (connectivityResult.contains(ConnectivityResult.none)) {
    //     throw Exception('No internet connection');
    //   }

    //   await firebaseAuth.signOut();
    // } catch (e) {
    //   throw Exception('Failed to sign out: $e');
    // }
  }

  @override
  Future<MyUser> signUpWithEmailAndPassword(
      NewUserFormParam newUserFormParam) async {
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
}
