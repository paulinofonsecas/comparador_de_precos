import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:comparador_de_precos/app/config/dependencies.dart';
import 'package:comparador_de_precos/app/params/new_user_form_param.dart';
import 'package:comparador_de_precos/data/models/my_user.dart';
import 'package:comparador_de_precos/data/repositories/authentication_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
part 'signup_event.dart';
part 'signup_state.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  SignupBloc(this._authenticationRepository) : super(const SignupInitial()) {
    on<CadastrarNovoUsuarioEvent>(_onCadastrarNovoUsuarioEvent);
  }

  final IAuthenticationRepository _authenticationRepository;

  FutureOr<void> _onCadastrarNovoUsuarioEvent(
    CadastrarNovoUsuarioEvent event,
    Emitter<SignupState> emit,
  ) async {
    emit(const SignupLoadingState());
    try {
      final result = await _authenticationRepository
          .signUpWithEmailAndPassword(event.newUserFormParam);

      await getIt<SharedPreferences>().setString(
        'token',
        Supabase.instance.client.auth.currentSession?.refreshToken ?? '',
      );

      emit(SignupSuccessState(result));
    } catch (e) {
      log(e.toString());
      emit(const SignupErrorState());
    }
  }
}
