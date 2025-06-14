import 'package:bloc/bloc.dart';
import 'package:comparador_de_precos/data/repositories/logista_repository.dart';
import 'package:comparador_de_precos/data/repositories/produto_with_price.dart';
import 'package:equatable/equatable.dart';

part 'atualizar_preco_state.dart';

class AtualizarPrecoCubit extends Cubit<AtualizarPrecoState> {
  AtualizarPrecoCubit(this.produtoWithPrice, this._lojistaRepository)
      : super(AtualizarPrecoInitial());

  final ProductWithPrice produtoWithPrice;
  final ILojistaRepository _lojistaRepository;

  Future<void> atualizarPreco(
    String productId,
    String alteradorId,
    double newPrice,
  ) async {
    try {
      emit(AtualizarPrecoLoading());

      await _lojistaRepository.updatePrice(
        produtoWithPrice.produto.id,
        alteradorId,
        newPrice,
      );

      emit(AtualizarPrecoSuccess());
    } catch (e) {
      emit(AtualizarPrecoFailure(e.toString()));
    }
  }
}
