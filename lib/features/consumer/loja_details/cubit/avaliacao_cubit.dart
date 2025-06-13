import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../data/models/avaliacao.dart';
import '../../../../data/repositories/avaliacao_repository.dart';

part 'avaliacao_state.dart';

class AvaliacaoCubit extends Cubit<AvaliacaoState> {
  final AvaliacaoRepository _avaliacaoRepository;

  AvaliacaoCubit(this._avaliacaoRepository) : super(AvaliacaoInitial());

  Future<void> fetchAvaliacoes(String lojaId) async {
    emit(AvaliacaoLoading());
    try {
      final avaliacoes = await _avaliacaoRepository.getAvaliacoesByLojaId(lojaId);
      final mediaClassificacao = await _avaliacaoRepository.getClassificacaoMediaByLojaId(lojaId);
      final numeroAvaliacoes = await _avaliacaoRepository.getNumeroAvaliacoesByLojaId(lojaId);
      
      emit(AvaliacaoSuccess(
        avaliacoes: avaliacoes,
        mediaClassificacao: mediaClassificacao,
        numeroAvaliacoes: numeroAvaliacoes,
      ));
    } catch (e) {
      emit(AvaliacaoFailure(error: e.toString()));
    }
  }

  Future<void> adicionarAvaliacao({
    required String lojaId,
    required String usuarioId,
    required String usuarioNome,
    required double classificacao,
    String? comentario,
  }) async {
    emit(AvaliacaoLoading());
    try {
      await _avaliacaoRepository.adicionarAvaliacao(
        lojaId: lojaId,
        usuarioId: usuarioId,
        usuarioNome: usuarioNome,
        classificacao: classificacao,
        comentario: comentario,
      );
      
      // Recarregar avaliações após adicionar uma nova
      await fetchAvaliacoes(lojaId);
    } catch (e) {
      emit(AvaliacaoFailure(error: e.toString()));
    }
  }
}
