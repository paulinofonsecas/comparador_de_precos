import 'package:bloc/bloc.dart';
import 'package:comparador_de_precos/data/repositories/product_catalog_repository.dart';
import 'package:equatable/equatable.dart';

part 'favorite_state.dart';

class FavoriteCubit extends Cubit<FavoriteState> {
  
  FavoriteCubit({required ProductCatalogRepository repository})
      : _repository = repository,
        super(const FavoriteInitial());
  final ProductCatalogRepository _repository;

  Future<void> checkFavoriteStatus(String productId) async {
    try {
      emit(const FavoriteLoading());
      final isFavorite = await _repository.isFavorite(productId);
      emit(FavoriteLoaded(isFavorite: isFavorite));
    } catch (e) {
      emit(FavoriteError(message: e.toString()));
    }
  }

  Future<void> toggleFavorite(String productId) async {
    try {
      emit(const FavoriteLoading());
      final isFavorite = await _repository.toggleFavorite(productId);
      emit(FavoriteLoaded(isFavorite: isFavorite));
    } catch (e) {
      emit(FavoriteError(message: e.toString()));
    }
  }
}
