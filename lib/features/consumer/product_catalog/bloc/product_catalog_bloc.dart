import 'package:bloc/bloc.dart';
import 'package:comparador_de_precos/data/models/produto.dart';
import 'package:comparador_de_precos/data/repositories/product_catalog_repository.dart';
import 'package:comparador_de_precos/features/consumer/product_catalog/bloc/product_catalog_event.dart';
import 'package:comparador_de_precos/features/consumer/product_catalog/bloc/product_catalog_state.dart';

class ProductCatalogBloc
    extends Bloc<ProductCatalogEvent, ProductCatalogState> {
  final ProductCatalogRepository _repository;
  static const int _pageSize = 15;

  ProductCatalogBloc({required ProductCatalogRepository repository})
      : _repository = repository,
        super(const ProductCatalogState()) {
    on<LoadProducts>(_onLoadProducts);
    on<LoadMoreProducts>(_onLoadMoreProducts);
    on<FilterByCategory>(_onFilterByCategory);
    on<LoadCategories>(_onLoadCategories);
  }

  Future<void> _onLoadProducts(
    LoadProducts event,
    Emitter<ProductCatalogState> emit,
  ) async {
    try {
      if (state.status == ProductCatalogStatus.loading && !event.refresh) {
        return;
      }

      emit(state.copyWith(
        status: ProductCatalogStatus.loading,
        errorMessage: null,
        currentPage: 0,
        produtos: event.refresh ? [] : state.produtos,
      ));

      final produtos = await _repository.getProdutos(
        categoriaId: event.categoryId == '0' ? null : event.categoryId,
        page: 0,
        pageSize: _pageSize,
      );

      final hasReachedMax = produtos.length < _pageSize;

      emit(state.copyWith(
        status: ProductCatalogStatus.success,
        produtos: produtos,
        hasReachedMax: hasReachedMax,
        currentPage: 0,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: ProductCatalogStatus.failure,
        errorMessage: e.toString(),
      ));
    }
  }

  Future<void> _onLoadMoreProducts(
    LoadMoreProducts event,
    Emitter<ProductCatalogState> emit,
  ) async {
    if (state.hasReachedMax || state.isLoadingMore) return;

    try {
      emit(state.copyWith(isLoadingMore: true));

      final nextPage = state.currentPage + 1;
      final newProdutos = await _repository.getProdutos(
        categoriaId: state.selectedCategoryId,
        page: nextPage,
        pageSize: _pageSize,
      );

      final hasReachedMax = newProdutos.length < _pageSize;

      if (newProdutos.isEmpty) {
        emit(state.copyWith(
          hasReachedMax: true,
          isLoadingMore: false,
        ));
      } else {
        final updatedProdutos = List<Produto>.from(state.produtos)
          ..addAll(newProdutos);

        emit(state.copyWith(
          status: ProductCatalogStatus.success,
          produtos: updatedProdutos,
          hasReachedMax: hasReachedMax,
          isLoadingMore: false,
          currentPage: nextPage,
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        isLoadingMore: false,
        errorMessage: e.toString(),
      ));
    }
  }

  Future<void> _onFilterByCategory(
    FilterByCategory event,
    Emitter<ProductCatalogState> emit,
  ) async {
    if (event.categoryId == state.selectedCategoryId) return;

    emit(state.copyWith(
      selectedCategoryId: event.categoryId,
      produtos: [],
      currentPage: 0,
      hasReachedMax: false,
    ));

    add(LoadProducts(categoryId: event.categoryId));
  }

  Future<void> _onLoadCategories(
    LoadCategories event,
    Emitter<ProductCatalogState> emit,
  ) async {
    try {
      final categorias = await _repository.getCategorias();
      emit(state.copyWith(categorias: categorias));
    } catch (e) {
      emit(state.copyWith(
        errorMessage: 'Erro ao carregar categorias: ${e.toString()}',
      ));
    }
  }
}
