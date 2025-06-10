import 'package:bloc/bloc.dart';
import 'package:comparador_de_precos/data/repositories/logista_repository.dart';
import 'package:comparador_de_precos/data/repositories/produto_with_price.dart';
import 'package:equatable/equatable.dart';

part 'get_produtos_associados_state.dart';

class GetProdutosAssociadosCubit extends Cubit<GetProdutosAssociadosState> {
  GetProdutosAssociadosCubit(this._lojistaRepository)
      : super(GetProdutosAssociadosInitial());

  final ILojistaRepository _lojistaRepository;

  Future<void> getProdutosAssociados(String lojistaId) async {
    emit(GetProdutosAssociadosLoading());
    try {
      final produtos =
          await _lojistaRepository.getProdutosAssociados(lojistaId);

      emit(GetProdutosAssociadosSuccess(produtos));
    } catch (e) {
      emit(GetProdutosAssociadosFailure(e.toString()));
    }
  }
}
