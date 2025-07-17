import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:comparador_de_precos/data/models/oferta_model.dart';
import 'package:equatable/equatable.dart';
part 'oferta_details_event.dart';
part 'oferta_details_state.dart';

class OfertaDetailsBloc extends Bloc<OfertaDetailsEvent, OfertaDetailsState> {
  OfertaDetailsBloc({required this.oferta})
      : super(const OfertaDetailsInitial()) {
    on<CustomOfertaDetailsEvent>(_onCustomOfertaDetailsEvent);
  }

  final Oferta oferta;

  FutureOr<void> _onCustomOfertaDetailsEvent(
    CustomOfertaDetailsEvent event,
    Emitter<OfertaDetailsState> emit,
  ) {}
}
