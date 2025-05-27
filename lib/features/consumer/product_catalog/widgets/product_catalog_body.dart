import 'package:comparador_de_precos/features/consumer/product_catalog/bloc/product_catalog_bloc.dart';
import 'package:comparador_de_precos/features/consumer/product_catalog/bloc/product_catalog_event.dart';
import 'package:comparador_de_precos/features/consumer/product_catalog/bloc/product_catalog_state.dart';
import 'package:comparador_de_precos/features/consumer/product_catalog/widgets/category_filter.dart';
import 'package:comparador_de_precos/features/consumer/product_catalog/widgets/product_item.dart';
import 'package:comparador_de_precos/features/consumer/product_details/view/product_details_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductCatalogBody extends StatefulWidget {
  const ProductCatalogBody({super.key});

  @override
  State<ProductCatalogBody> createState() => _ProductCatalogBodyState();
}

class _ProductCatalogBodyState extends State<ProductCatalogBody> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isBottom) {
      context.read<ProductCatalogBloc>().add(LoadMoreProducts());
    }
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    // Carrega mais quando estiver a 200 pixels do final
    return currentScroll >= (maxScroll - 200);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductCatalogBloc, ProductCatalogState>(
      builder: (context, state) {
        // Exibe o filtro de categorias se houver categorias carregadas
        final hasCategories = state.categorias.isNotEmpty;
    
        return Column(
          children: [
            // Filtro de categorias
            if (hasCategories)
              CategoryFilter(
                categorias: state.categorias,
                selectedCategoryId: state.selectedCategoryId,
                onCategorySelected: (categoryId) {
                  context
                      .read<ProductCatalogBloc>()
                      .add(FilterByCategory(categoryId));
                },
              ),
    
            // Lista de produtos
            Expanded(
              child: _buildProductList(context, state),
            ),
          ],
        );
      },
    );
  }

  Widget _buildProductList(BuildContext context, ProductCatalogState state) {
    switch (state.status) {
      case ProductCatalogStatus.initial:
      case ProductCatalogStatus.loading:
        if (state.produtos.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }
        return _buildProductListView(context, state);

      case ProductCatalogStatus.success:
        if (state.produtos.isEmpty) {
          return const Center(
            child: Text(
              'Nenhum produto disponível nesta categoria',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
          );
        }
        return _buildProductListView(context, state);

      case ProductCatalogStatus.failure:
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Erro ao carregar produtos',
                style: TextStyle(fontSize: 16, color: Colors.red[700]),
              ),
              const SizedBox(height: 8),
              ElevatedButton(
                onPressed: () {
                  context
                      .read<ProductCatalogBloc>()
                      .add(const LoadProducts(refresh: true));
                },
                child: const Text('Tentar novamente'),
              ),
            ],
          ),
        );
    }
  }

  Widget _buildProductListView(
      BuildContext context, ProductCatalogState state) {
    return RefreshIndicator(
      onRefresh: () async {
        context
            .read<ProductCatalogBloc>()
            .add(const LoadProducts(refresh: true));
      },
      child: ListView.builder(
        controller: _scrollController,
        itemCount: state.produtos.length + (state.hasReachedMax ? 0 : 1),
        padding: const EdgeInsets.only(bottom: 16),
        itemBuilder: (context, index) {
          // Mostrar indicador de carregamento no final da lista
          if (index >= state.produtos.length) {
            return const Center(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 16),
                child: CircularProgressIndicator(),
              ),
            );
          }

          final produto = state.produtos[index];
          return ProductListItem(
            produto: produto,
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute<void>(
                  builder: (context) =>
                      ProductDetailsPage(productId: produto.id),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
