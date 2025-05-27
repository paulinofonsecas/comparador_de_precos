import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
part 'oferta_details_event.dart';
part 'oferta_details_state.dart';

class OfertaDetailsBloc extends Bloc<OfertaDetailsEvent, OfertaDetailsState> {
  OfertaDetailsBloc() : super(const OfertaDetailsInitial()) {
    on<CustomOfertaDetailsEvent>(_onCustomOfertaDetailsEvent);
  }

  FutureOr<void> _onCustomOfertaDetailsEvent(
    CustomOfertaDetailsEvent event,
    Emitter<OfertaDetailsState> emit,
  ) {
    // TODO: Add Logic
  }
}
