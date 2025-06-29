import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:comparador_de_precos/data/models/loja.dart';
import 'package:comparador_de_precos/data/models/user_profile.dart';
import 'package:comparador_de_precos/data/repositories/loja_repository.dart';
import 'package:equatable/equatable.dart';
part 'admin_loja_details_event.dart';
part 'admin_loja_details_state.dart';

class AdminLojaDetailsBloc
    extends Bloc<AdminLojaDetailsEvent, AdminLojaDetailsState> {
  AdminLojaDetailsBloc(this.lojaRepository)
      : super(const AdminLojaDetailsInitial()) {
    on<LoadAdminLojaDetailsEvent>(
      _onLoadAdminLojaDetailsEvent,
    );
    on<AdminLojaDetailsAlterarLojistaEvent>(
      _onAdminLojaDetailsAlterarLojistaEvent,
    );
  }

  final LojaRepository lojaRepository;

  FutureOr<void> _onLoadAdminLojaDetailsEvent(
    LoadAdminLojaDetailsEvent event,
    Emitter<AdminLojaDetailsState> emit,
  ) async {
    emit(AdminLojaDetailsLoading());
    try {
      final lojaDetails = await lojaRepository.getLojaById(event.lojaId);

      if (lojaDetails == null) {
        emit(const AdminLojaDetailsError(message: 'Loja não encontrada'));
        return;
      }
      emit(AdminLojaDetailsLoaded(loja: lojaDetails));
    } catch (e) {
      emit(AdminLojaDetailsError(message: e.toString()));
    }
  }

  FutureOr<void> _onAdminLojaDetailsAlterarLojistaEvent(
    AdminLojaDetailsAlterarLojistaEvent event,
    Emitter<AdminLojaDetailsState> emit,
  ) async {
    try {
      final loja = await lojaRepository.alterarLojista(
          event.lojaId, event.novoLojistaId);

      if (loja == null) {
        emit(const AdminLojaDetailsError(message: 'Loja não encontrada'));
        return;
      }

      emit(AdminLojaDetailsLoaded(loja: loja));
    } catch (e) {
      emit(AdminLojaDetailsError(message: e.toString()));
    }
  }
}
