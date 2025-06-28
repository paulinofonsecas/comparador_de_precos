import 'package:bloc/bloc.dart';
import 'package:comparador_de_precos/data/repositories/loja_repository.dart';
import 'package:equatable/equatable.dart';

part 'aprovar_loja_state.dart';

class AprovarLojaCubit extends Cubit<AprovarLojaState> {
  AprovarLojaCubit(this._lojaRepository) : super(AprovarLojaInitial());

  final LojaRepository _lojaRepository;

  Future<void> aprovarLoja(String lojaId) async {
    emit(AprovarLojaLoading());
    try {
      await _lojaRepository.aprovarLoja(lojaId);

      emit(AprovarLojaSuccess());
    } catch (e) {
      emit(AprovarLojaFailure(e.toString()));
    }
  }
}
