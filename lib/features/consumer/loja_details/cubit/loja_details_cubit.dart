import 'package:bloc/bloc.dart';
import 'package:comparador_de_precos/data/models/loja.dart';
import 'package:comparador_de_precos/data/repositories/loja_repository.dart';
import 'package:equatable/equatable.dart';

part 'loja_details_state.dart';

class LojaDetailsCubit extends Cubit<LojaDetailsState> {
  LojaDetailsCubit(this._lojaRepository) : super(LojaDetailsInitial());

  final LojaRepository _lojaRepository;

  Future<void> fetchLojaDetails(String lojaId) async {
    emit(LojaDetailsLoading());
    try {
      // Assuming LojaRepository has getLojaById method
      // This might be a different method if we already have basic loja info
      // and want to fetch more details like products.
      // For now, let's assume it fetches the complete Loja object again or an enhanced one.
      final loja = await _lojaRepository.getLojaById(lojaId);
      if (loja != null) {
        emit(LojaDetailsSuccess(loja));
      } else {
        emit(const LojaDetailsFailure('Loja não encontrada'));
      }
    } catch (e) {
      emit(LojaDetailsFailure(e.toString()));
    }
  }
}
