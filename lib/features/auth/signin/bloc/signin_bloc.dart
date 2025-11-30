import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:comparador_de_precos/app/config/dependencies.dart';
import 'package:comparador_de_precos/data/models/my_user.dart';
import 'package:comparador_de_precos/data/repositories/authentication_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';
part 'signin_event.dart';
part 'signin_state.dart';

class SigninBloc extends Bloc<SigninEvent, SigninState> {
  SigninBloc(this._authenticationRepository) : super(const SigninInitial()) {
    on<SigninWithEmailAndPasswordEvent>(_onSigninWithEmailAndPasswordEvent);
    on<CheckUserLocalLoginEvent>(_onCheckUserLocalLoginEvent);
  }

  final IAuthenticationRepository _authenticationRepository;

  FutureOr<void> _onCheckUserLocalLoginEvent(
    CheckUserLocalLoginEvent event,
    Emitter<SigninState> emit,
  ) async {
    emit(const SigninLoading());

    try {
      final prefs = getIt<SharedPreferences>();
      final token = prefs.getString('token');

      if (token != null) {
        final result = await _authenticationRepository.getUser(token);

        if (result == null) {
          emit(const SigninInitial());
          return;
        }

        emit(SigninSuccess(result));
      } else {
        emit(const SigninInitial());
      }
    } catch (e) {
      log(e.toString());
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

      emit(SigninSuccess(user));
    } catch (e) {
      log(e.toString());
      emit(SigninError(e.toString()));
    }
  }
}
