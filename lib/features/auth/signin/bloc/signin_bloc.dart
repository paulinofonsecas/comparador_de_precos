import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:comparador_de_precos/app/config/errors/signin_error.dart';
import 'package:comparador_de_precos/data/models/my_user.dart';
import 'package:comparador_de_precos/data/repositories/authentication_repository.dart';
import 'package:equatable/equatable.dart';
part 'signin_event.dart';
part 'signin_state.dart';

class SigninBloc extends Bloc<SigninEvent, SigninState> {
  SigninBloc(this._authenticationRepository) : super(const SigninInitial()) {
    on<SigninWithEmailAndPasswordEvent>(_onSigninWithEmailAndPasswordEvent);
  }

  final AuthenticationRepository _authenticationRepository;

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
    } on Exception catch (e) {
      emit(SigninError(e.toString()));
    }
  }
}
