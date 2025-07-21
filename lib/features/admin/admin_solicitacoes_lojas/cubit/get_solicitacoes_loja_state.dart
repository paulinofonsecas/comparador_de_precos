part of 'get_solicitacoes_loja_cubit.dart';

sealed class GetSolicitacoesLojaState extends Equatable {
  const GetSolicitacoesLojaState();

  @override
  List<Object> get props => [];
}

final class GetSolicitacoesLojaInitial extends GetSolicitacoesLojaState {}

final class GetSolicitacoesLojaLoading extends GetSolicitacoesLojaState {}

final class GetSolicitacoesLojaLoaded extends GetSolicitacoesLojaState {
  const GetSolicitacoesLojaLoaded(this.solicitacoes);

  final List<SolicitacaoLoja> solicitacoes;

  @override
  List<Object> get props => [solicitacoes];
}

final class GetSolicitacoesLojaError extends GetSolicitacoesLojaState {
  const GetSolicitacoesLojaError(this.message);

  final String message;

  @override
  List<Object> get props => [message];
}
