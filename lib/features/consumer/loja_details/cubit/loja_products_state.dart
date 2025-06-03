import 'package:comparador_de_precos/data/models/produto.dart';
import 'package:equatable/equatable.dart';

enum LojaProductsStatus { initial, loading, success, failure }

class LojaProductsState extends Equatable {
  const LojaProductsState({
    this.status = LojaProductsStatus.initial,
    this.produtos = const [],
    this.errorMessage = '',
    this.searchQuery = '',
    this.selectedCategoryId,
    this.priceFilter = 'Todos',
  });

  final LojaProductsStatus status;
  final List<Produto> produtos;
  final String errorMessage;
  final String searchQuery;
  final String? selectedCategoryId;
  final String priceFilter;

  LojaProductsState copyWith({
    LojaProductsStatus? status,
    List<Produto>? produtos,
    String? errorMessage,
    String? searchQuery,
    String? Function()? selectedCategoryId,
    String? priceFilter,
  }) {
    return LojaProductsState(
      status: status ?? this.status,
      produtos: produtos ?? this.produtos,
      errorMessage: errorMessage ?? this.errorMessage,
      searchQuery: searchQuery ?? this.searchQuery,
      selectedCategoryId: selectedCategoryId != null
          ? selectedCategoryId()
          : this.selectedCategoryId,
      priceFilter: priceFilter ?? this.priceFilter,
    );
  }

  List<Produto> get filteredProducts {
    return produtos.where((product) {
      // Apply search filter
      final matchesSearch = searchQuery.isEmpty ||
          product.nome.toLowerCase().contains(searchQuery.toLowerCase()) ||
          (product.marca?.toLowerCase().contains(searchQuery.toLowerCase()) ??
              false);

      // Apply category filter
      final matchesCategory = selectedCategoryId == null ||
          selectedCategoryId == '0' ||
          product.categoriaId == selectedCategoryId;

      return matchesSearch && matchesCategory;
    }).toList()
      ..sort((a, b) {
        // Apply price filter
        if (priceFilter == 'Menor preço') {
          return (a.precoMinimo ?? 0).compareTo(b.precoMinimo ?? 0);
        } else if (priceFilter == 'Maior preço') {
          return (b.precoMinimo ?? 0).compareTo(a.precoMinimo ?? 0);
        }
        return 0;
      });
  }

  @override
  List<Object?> get props => [
        status,
        produtos,
        errorMessage,
        searchQuery,
        selectedCategoryId,
        priceFilter,
      ];
}