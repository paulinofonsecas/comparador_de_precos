import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
part 'solicitar_cadastro_event.dart';
part 'solicitar_cadastro_state.dart';

class SolicitarCadastroBloc extends Bloc<SolicitarCadastroEvent, SolicitarCadastroState> {
  SolicitarCadastroBloc() : super(const SolicitarCadastroInitial()) {
    on<CustomSolicitarCadastroEvent>(_onCustomSolicitarCadastroEvent);
  }

  FutureOr<void> _onCustomSolicitarCadastroEvent(
    CustomSolicitarCadastroEvent event,
    Emitter<SolicitarCadastroState> emit,
  ) {
    // TODO: Add Logic
  }
}
