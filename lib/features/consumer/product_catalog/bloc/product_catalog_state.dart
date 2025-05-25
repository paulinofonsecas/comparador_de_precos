import 'package:comparador_de_precos/data/models/categoria.dart';
import 'package:comparador_de_precos/data/models/produto.dart';
import 'package:equatable/equatable.dart';

enum ProductCatalogStatus { initial, loading, success, failure }

class ProductCatalogState extends Equatable {
  final ProductCatalogStatus status;
  final List<Produto> produtos;
  final List<Categoria> categorias;
  final String? selectedCategoryId;
  final bool hasReachedMax;
  final bool isLoadingMore;
  final String? errorMessage;
  final int currentPage;

  const ProductCatalogState({
    this.status = ProductCatalogStatus.initial,
    this.produtos = const [],
    this.categorias = const [],
    this.selectedCategoryId,
    this.hasReachedMax = false,
    this.isLoadingMore = false,
    this.errorMessage,
    this.currentPage = 0,
  });

  ProductCatalogState copyWith({
    ProductCatalogStatus? status,
    List<Produto>? produtos,
    List<Categoria>? categorias,
    String? selectedCategoryId,
    bool? hasReachedMax,
    bool? isLoadingMore,
    String? errorMessage,
    int? currentPage,
  }) {
    return ProductCatalogState(
      status: status ?? this.status,
      produtos: produtos ?? this.produtos,
      categorias: categorias ?? this.categorias,
      selectedCategoryId: selectedCategoryId ?? this.selectedCategoryId,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      errorMessage: errorMessage ?? this.errorMessage,
      currentPage: currentPage ?? this.currentPage,
    );
  }

  @override
  List<Object?> get props => [
        status,
        produtos,
        categorias,
        selectedCategoryId,
        hasReachedMax,
        isLoadingMore,
        errorMessage,
        currentPage,
      ];
}
