import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:comparador_de_precos/data/models/user_profile.dart';
import 'package:comparador_de_precos/data/repositories/authentication_repository.dart';
import 'package:equatable/equatable.dart';

part 'get_logista_profile_state.dart';

class GetLogistaProfileCubit extends Cubit<GetLogistaProfileState> {
  GetLogistaProfileCubit(this.repository) : super(GetLogistaProfileInitial());

  final AuthenticationRepository repository;

  Future<void> getLogistaProfile(String userId) async {
    emit(GetLogistaProfileLoading());

    try {
      final profile = await repository.getLogistaProfile(userId);

      if (profile == null) {
        emit(const GetLogistaProfileFailure('Usuário não encontrado'));
      } else {
        emit(GetLogistaProfileSuccess(profile));
      }
    } catch (e) {
      log(e.toString());
      emit(
        const GetLogistaProfileFailure('Ocorreu um erro ao buscar o usuario!'),
      );
    }
  }
}
