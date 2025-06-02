import 'package:bloc/bloc.dart';
import 'package:comparador_de_precos/data/models/loja.dart';
import 'package:comparador_de_precos/data/repositories/loja_repository.dart';
import 'package:equatable/equatable.dart';

part 'get_loja_state.dart';

class GetLojaCubit extends Cubit<GetLojaState> {
  GetLojaCubit(this.lojaRepository) : super(GetLojaInitial());

  final LojaRepository lojaRepository;

  Future<void> getLojaById(String id) async {
    emit(GetLojaLoading());
    try {
      final loja = await lojaRepository.getLojaById(id);

      if (loja == null) {
        emit(const GetLojaFailure('Loja não encontrada'));
        return;
      }

      emit(GetLojaSuccess(loja));
    } catch (e) {
      emit(GetLojaFailure(e.toString()));
    }
  }
}
