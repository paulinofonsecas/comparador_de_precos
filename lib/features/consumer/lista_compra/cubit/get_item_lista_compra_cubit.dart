import 'package:bloc/bloc.dart';
import 'package:comparador_de_precos/app/config/dependencies.dart';
import 'package:comparador_de_precos/data/models/lista_compra.dart';
import 'package:comparador_de_precos/data/repositories/lista_compra_repository.dart';
import 'package:equatable/equatable.dart';

part 'get_item_lista_compra_state.dart';

class GetItemListaCompraCubit extends Cubit<GetItemListaCompraState> {
  GetItemListaCompraCubit() : super(GetItemListaCompraInitial());

  final _listaCompraRepository = getIt<ListaCompraRepository>();

  Future<void> getItems(String listaId) async {
    emit(GetItemListaCompraLoading());
    try {
      final itens = await _listaCompraRepository.getItemsListaCompra(listaId);
      emit(GetItemListaCompraSuccess(itens: itens));
    } catch (e) {
      emit(GetItemListaCompraError(message: e.toString()));
    }
  }
}
