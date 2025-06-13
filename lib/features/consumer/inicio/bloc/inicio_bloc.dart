import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:comparador_de_precos/data/models/loja.dart';
import 'package:comparador_de_precos/data/repositories/loja_repository.dart';
import 'package:equatable/equatable.dart';

part 'inicio_event.dart';
part 'inicio_state.dart';

class InicioBloc extends Bloc<InicioEvent, InicioState> {
  InicioBloc({required LojaRepository lojaRepository}) 
    : _lojaRepository = lojaRepository,
      super(const InicioInitial()) {
    on<LoadLojasParaVoceEvent>(_onLoadLojasParaVoceEvent);
  }
  
  final LojaRepository _lojaRepository;

  FutureOr<void> _onLoadLojasParaVoceEvent(
    LoadLojasParaVoceEvent event,
    Emitter<InicioState> emit,
  ) async {
    emit(state.copyWith(status: InicioStatus.loading));
    try {
      final lojas = await _lojaRepository.getAllLojas();
      emit(state.copyWith(
        status: InicioStatus.success,
        lojasParaVoce: lojas,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: InicioStatus.failure,
        errorMessage: () => 'Erro ao carregar lojas: $e',
      ));
    }
  }
}
