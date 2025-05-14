import 'package:comparador_de_precos/data/models/my_user.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class AuthenticationRepository {
  Future<MyUser> signInWithEmailAndPassword(String email, String password);
  Future<void> signOut();
  Future<MyUser> signUpWithEmailAndPassword(
    MyUser user,
    String password,
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
      throw Exception('Ocorreu um erro desconhecido, tente novamente.');
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
    MyUser user,
    String password,
  ) async {
    try {
      // Check if the device is connected to the internet
      final connectivityResult = await connectivity.checkConnectivity();
      if (connectivityResult.contains(ConnectivityResult.none)) {
        throw Exception('No internet connection');
      }

      final authResponse = await supabaseClient.auth.signUp(
        email: user.email,
        password: password,
        data: {
          'name': user.displayName,
          'avatar_url': user.photoURL,
          'user_type': user.userType,
        },
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
      throw Exception('Ocorreu um erro desconhecido, tente novamente.');
    }
  }

  @override
  Future<void> verifyEmail() {
    // TODO: implement verifyEmail
    throw UnimplementedError();
  }
}
