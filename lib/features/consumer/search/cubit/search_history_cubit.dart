import 'package:bloc/bloc.dart';
import 'package:comparador_de_precos/app/config/dependencies.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'search_history_state.dart';

class SearchHistoryCubit extends Cubit<SearchHistoryState> {
  SearchHistoryCubit() : super(SearchHistoryInitial());

  final SharedPreferences sp = getIt();
  final String storageKey = 'search_history';

  Future<void> saveItem(String newItem) async {
    final listaAntiga = sp.getStringList(storageKey) ?? []
      ..add(newItem);

    await sp.setStringList(storageKey, listaAntiga);
  }

  Future<void> retriveItems() async {
    try {
      final list = sp.getStringList(storageKey) ?? [];

      emit(SearchHistorySuccess(list.reversed.toList()));
    } catch (e) {
      emit(const SearchHistoryError('Ocorreu um erro ao buscar o historico'));
    }
  }

  void removeItem(String historyItem) {
    final listaAntiga = sp.getStringList(storageKey) ?? [];
    final listaNova = listaAntiga.where((e) => e != historyItem).toList();

    sp.setStringList(storageKey, listaNova);

    emit(SearchHistoryRemovedItem());
  }
}
