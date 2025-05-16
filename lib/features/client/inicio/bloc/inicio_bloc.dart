import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
part 'inicio_event.dart';
part 'inicio_state.dart';

class InicioBloc extends Bloc<InicioEvent, InicioState> {
  InicioBloc() : super(const InicioInitial()) {
    on<CustomInicioEvent>(_onCustomInicioEvent);
  }

  FutureOr<void> _onCustomInicioEvent(
    CustomInicioEvent event,
    Emitter<InicioState> emit,
  ) {
    // TODO: Add Logic
  }
}
