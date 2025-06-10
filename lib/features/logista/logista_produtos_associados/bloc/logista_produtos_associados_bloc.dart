import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
part 'logista_produtos_associados_event.dart';
part 'logista_produtos_associados_state.dart';

class LogistaProdutosAssociadosBloc extends Bloc<LogistaProdutosAssociadosEvent, LogistaProdutosAssociadosState> {
  LogistaProdutosAssociadosBloc() : super(const LogistaProdutosAssociadosInitial()) {
    on<CustomLogistaProdutosAssociadosEvent>(_onCustomLogistaProdutosAssociadosEvent);
  }

  FutureOr<void> _onCustomLogistaProdutosAssociadosEvent(
    CustomLogistaProdutosAssociadosEvent event,
    Emitter<LogistaProdutosAssociadosState> emit,
  ) {
    // TODO: Add Logic
  }
}
