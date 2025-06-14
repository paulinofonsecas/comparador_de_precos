part of 'atualizar_promotion_preco_cubit.dart';

sealed class AtualizarPromotionPrecoState extends Equatable {
  const AtualizarPromotionPrecoState();

  @override
  List<Object> get props => [];
}

final class AtualizarPromotionPrecoInitial
    extends AtualizarPromotionPrecoState {}

final class AtualizarPromotionPrecoLoading
    extends AtualizarPromotionPrecoState {}

final class AtualizarPromotionPrecoSuccess
    extends AtualizarPromotionPrecoState {}

final class AtualizarPromotionPrecoFailure
    extends AtualizarPromotionPrecoState {
  const AtualizarPromotionPrecoFailure(this.message);

  final String message;

  @override
  List<Object> get props => [message];
}
