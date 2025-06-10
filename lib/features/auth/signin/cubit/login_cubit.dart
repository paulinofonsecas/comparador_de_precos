import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:comparador_de_precos/app/config/dependencies.dart';
import 'package:comparador_de_precos/data/repositories/authentication_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit(this.auth) : super(LoginInitial());

  final AuthenticationRepository auth;

  FutureOr<void> signOut() async {
    emit(LogoutLoading());

    try {
      await auth.signOut();
      await getIt<SharedPreferences>().remove('token');

      emit(LogoutSuccess());
    } catch (e) {
      log(e.toString());
      emit(const LoginFailure('Logout failed'));
    }
  }
}
