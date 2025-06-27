import 'package:bloc/bloc.dart';
import 'package:comparador_de_precos/data/models/loja.dart';
import 'package:comparador_de_precos/data/repositories/loja_repository.dart';
import 'package:equatable/equatable.dart';

part 'search_lojas_state.dart';

class SearchLojasCubit extends Cubit<SearchLojasState> {
  SearchLojasCubit(this.lojaRepository) : super(SearchLojasInitial());

  final LojaRepository lojaRepository;

  Future<void> search(String query) async {
    emit(SearchLojasLoading());

    try {
      final lojas = await lojaRepository.searchLojas(query);
      emit(SearchLojasSuccess(lojas));
    } catch (error) {
      emit(SearchLojasFailure(error.toString()));
    }
  }
}
