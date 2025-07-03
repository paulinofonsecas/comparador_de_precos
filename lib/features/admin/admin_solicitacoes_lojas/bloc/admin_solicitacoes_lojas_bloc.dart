import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
part 'admin_solicitacoes_lojas_event.dart';
part 'admin_solicitacoes_lojas_state.dart';

class AdminSolicitacoesLojasBloc extends Bloc<AdminSolicitacoesLojasEvent, AdminSolicitacoesLojasState> {
  AdminSolicitacoesLojasBloc() : super(const AdminSolicitacoesLojasInitial()) {
    on<CustomAdminSolicitacoesLojasEvent>(_onCustomAdminSolicitacoesLojasEvent);
  }

  FutureOr<void> _onCustomAdminSolicitacoesLojasEvent(
    CustomAdminSolicitacoesLojasEvent event,
    Emitter<AdminSolicitacoesLojasState> emit,
  ) {
    // TODO: Add Logic
  }
}
