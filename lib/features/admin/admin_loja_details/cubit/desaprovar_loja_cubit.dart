import 'package:bloc/bloc.dart';
import 'package:comparador_de_precos/data/repositories/loja_repository.dart';
import 'package:equatable/equatable.dart';

part 'desaprovar_loja_state.dart';

class DesaprovarLojaCubit extends Cubit<DesaprovarLojaState> {
  DesaprovarLojaCubit(this._lojaRepository) : super(DesaprovarLojaInitial());

  final LojaRepository _lojaRepository;

  Future<void> desaprovarLoja(String lojaId) async {
    emit(DesaprovarLojaLoading());
    try {
      await _lojaRepository.desaprovarLoja(lojaId);

      emit(DesaprovarLojaSuccess());
    } catch (e) {
      emit(DesaprovarLojaFailure(e.toString()));
    }
  }
}
