part of 'atualizar_preco_cubit.dart';

sealed class AtualizarPrecoState extends Equatable {
  const AtualizarPrecoState();

  @override
  List<Object> get props => [];
}

final class AtualizarPrecoInitial extends AtualizarPrecoState {}

final class AtualizarPrecoLoading extends AtualizarPrecoState {}

final class AtualizarPrecoSuccess extends AtualizarPrecoState {}

final class AtualizarPrecoFailure extends AtualizarPrecoState {
  const AtualizarPrecoFailure(this.message);

  final String message;

  @override
  List<Object> get props => [message];
}
