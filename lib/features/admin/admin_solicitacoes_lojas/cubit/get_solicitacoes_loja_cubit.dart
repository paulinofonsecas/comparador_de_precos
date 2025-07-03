import 'package:bloc/bloc.dart';
import 'package:comparador_de_precos/data/repositories/solicitacoes_loja.dart';
import 'package:equatable/equatable.dart';

part 'get_solicitacoes_loja_state.dart';

class GetSolicitacoesLojaCubit extends Cubit<GetSolicitacoesLojaState> {
  GetSolicitacoesLojaCubit(this._repository)
      : super(GetSolicitacoesLojaInitial());

  final SolicitacoesLojaRepository _repository;

  Future<void> getSolicitacoes() async {
    emit(GetSolicitacoesLojaLoading());
    try {
      final solicitacoes = await _repository.getSolicitacoes();
      emit(GetSolicitacoesLojaLoaded(solicitacoes));
    } catch (e) {
      emit(GetSolicitacoesLojaError(e.toString()));
    }
  }
}
