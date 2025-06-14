import 'package:bloc/bloc.dart';
import 'package:comparador_de_precos/data/repositories/logista_repository.dart';
import 'package:comparador_de_precos/data/repositories/produto_with_price.dart';
import 'package:equatable/equatable.dart';

part 'atualizar_promotion_preco_state.dart';

class AtualizarPromotionPrecoCubit extends Cubit<AtualizarPromotionPrecoState> {
  AtualizarPromotionPrecoCubit(this.produtoWithPrice, this._lojistaRepository)
      : super(AtualizarPromotionPrecoInitial());

  final ProductWithPrice produtoWithPrice;
  final ILojistaRepository _lojistaRepository;

  Future<void> atualizarPromotionPreco(
    String productId,
    String alteradorId,
    double? newPrice,
  ) async {
    try {
      emit(AtualizarPromotionPrecoLoading());

      await _lojistaRepository.updatePromotionPrice(
        produtoWithPrice.produto.id,
        alteradorId,
        newPrice,
      );

      emit(AtualizarPromotionPrecoSuccess());
    } catch (e) {
      emit(AtualizarPromotionPrecoFailure(e.toString()));
    }
  }
}
