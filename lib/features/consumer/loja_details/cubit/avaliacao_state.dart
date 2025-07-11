part of 'avaliacao_cubit.dart';

abstract class AvaliacaoState extends Equatable {
  const AvaliacaoState();

  @override
  List<Object?> get props => [];
}

class AvaliacaoInitial extends AvaliacaoState {}

class AvaliacaoLoading extends AvaliacaoState {}

class AvaliacaoSuccess extends AvaliacaoState {

  const AvaliacaoSuccess({
    required this.avaliacoes,
    required this.mediaClassificacao,
    required this.numeroAvaliacoes,
  });
  final List<Avaliacao> avaliacoes;
  final double mediaClassificacao;
  final int numeroAvaliacoes;

  @override
  List<Object?> get props => [avaliacoes, mediaClassificacao, numeroAvaliacoes];
}

class AvaliacaoFailure extends AvaliacaoState {

  const AvaliacaoFailure({required this.error});
  final String error;

  @override
  List<Object?> get props => [error];
}
