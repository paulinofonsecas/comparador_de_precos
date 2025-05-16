import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:comparador_de_precos/app/config/dependencies.dart';
import 'package:comparador_de_precos/data/models/my_user.dart';
import 'package:comparador_de_precos/data/repositories/authentication_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
part 'signin_event.dart';
part 'signin_state.dart';

class SigninBloc extends Bloc<SigninEvent, SigninState> {
  SigninBloc(this._authenticationRepository) : super(const SigninInitial()) {
    on<SigninWithEmailAndPasswordEvent>(_onSigninWithEmailAndPasswordEvent);
    on<CheckUserLocalLoginEvent>(_onCheckUserLocalLoginEvent);
  }

  final AuthenticationRepository _authenticationRepository;

  FutureOr<void> _onCheckUserLocalLoginEvent(
    CheckUserLocalLoginEvent event,
    Emitter<SigninState> emit,
  ) async {
    emit(const SigninLoading());

    try {
      final prefs = getIt<SharedPreferences>();
      final token = prefs.getString('token');

      if (token != null) {
        final authResponse =
            await Supabase.instance.client.auth.setSession(token);

        final myUser = MyUser(
          id: authResponse.user!.id,
          email: authResponse.user!.email!,
          displayName:
              authResponse.user?.userMetadata!['displayName'] as String?,
          photoURL: authResponse.user?.userMetadata!['photoURL'] as String?,
          userType:
              authResponse.user?.userMetadata!['userType'] as String? ?? 'user',
        );

        emit(SigninSuccess(myUser));
      } else {
        emit(const SigninInitial());
      }
    } catch (e) {
      emit(const SigninInitial());
    }
  }

  FutureOr<void> _onSigninWithEmailAndPasswordEvent(
    SigninWithEmailAndPasswordEvent event,
    Emitter<SigninState> emit,
  ) async {
    emit(const SigninLoading());

    try {
      final user = await _authenticationRepository.signInWithEmailAndPassword(
        event.email,
        event.password,
      );

      await getIt<SharedPreferences>().setString(
        'token',
        Supabase.instance.client.auth.currentSession?.refreshToken ?? '',
      );

      emit(SigninSuccess(user));
    } catch (e) {
      emit(SigninError(e.toString()));
    }
  }
}
