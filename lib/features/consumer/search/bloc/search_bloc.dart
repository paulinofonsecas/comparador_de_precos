import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:comparador_de_precos/data/models/produto.dart';
import 'package:comparador_de_precos/data/repositories/search_repository.dart';
import 'package:equatable/equatable.dart';
part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc(this._repository) : super(const SearchInitial()) {
    on<SearchProductEvent>(_onSearchProductEvent);
  }

  final SearchProductRepository _repository;

  FutureOr<void> _onSearchProductEvent(
    SearchProductEvent event,
    Emitter<SearchState> emit,
  ) async {
    try {
      emit(SearchProductsLoading());

      final products = await _repository.searchProducts(event.searchText);
      emit(SearchProductsSuccess(products));
    } catch (e) {
      emit(SearchProductsError(e.toString()));
    }
  }
}
