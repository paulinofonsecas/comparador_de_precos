import 'package:bloc/bloc.dart';
import 'package:comparador_de_precos/data/models/categoria.dart';
import 'package:comparador_de_precos/data/repositories/product_catalog_repository.dart';

import 'loja_products_state.dart';

class LojaProductsCubit extends Cubit<LojaProductsState> {
  LojaProductsCubit({
    required this.productRepository,
    required this.lojaId,
  }) : super(const LojaProductsState());

  final ProductCatalogRepository productRepository;
  final String lojaId;
  List<Categoria> categorias = [];

  Future<void> loadProducts() async {
    emit(state.copyWith(status: LojaProductsStatus.loading));

    try {
      final produtos = await productRepository.getProductsByMarketId(
        marketId: lojaId,
      );

      // Load categories
      categorias = await productRepository.getCategorias();
      // Add "All" category at the beginning
      categorias.insert(0, Categoria(id: '0', nome: 'Todas'));

      emit(state.copyWith(
        status: LojaProductsStatus.success,
        produtos: produtos,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: LojaProductsStatus.failure,
        errorMessage: e.toString(),
      ));
    }
  }

  void updateSearchQuery(String query) {
    emit(state.copyWith(searchQuery: query));
  }

  void updateCategoryFilter(String? categoryId) {
    emit(state.copyWith(
      selectedCategoryId: () => categoryId,
    ));
  }

  void updatePriceFilter(String filter) {
    emit(state.copyWith(priceFilter: filter));
  }
}
