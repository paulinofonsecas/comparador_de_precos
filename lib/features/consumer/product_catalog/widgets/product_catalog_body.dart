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
        final theme = Theme.of(context);
    
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
            
            // Indicador de categoria selecionada ou busca
            if (state.selectedCategoryId != null && hasCategories)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Row(
                  children: [
                    Text(
                      'Exibindo produtos da categoria: ',
                      style: TextStyle(
                        fontSize: 14,
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                    Text(
                      state.categorias
                          .firstWhere(
                            (cat) => cat.id == state.selectedCategoryId,
                            orElse: () => state.categorias.first,
                          )
                          .nome,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: theme.colorScheme.primary,
                      ),
                    ),
                  ],
                ),
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
    final theme = Theme.of(context);
    
    switch (state.status) {
      case ProductCatalogStatus.initial:
      case ProductCatalogStatus.loading:
        if (state.produtos.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 60,
                  height: 60,
                  child: CircularProgressIndicator(
                    color: theme.colorScheme.primary,
                    strokeWidth: 3,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'Carregando produtos...',
                  style: TextStyle(
                    fontSize: 16,
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          );
        }
        return _buildProductListView(context, state);

      case ProductCatalogStatus.success:
        if (state.produtos.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.inventory_2_outlined,
                  size: 64,
                  color: theme.colorScheme.onSurfaceVariant.withOpacity(0.5),
                ),
                const SizedBox(height: 16),
                Text(
                  'Nenhum produto disponível',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  state.selectedCategoryId != null
                      ? 'Tente selecionar outra categoria'
                      : 'Tente novamente mais tarde',
                  style: TextStyle(
                    fontSize: 14,
                    color: theme.colorScheme.onSurfaceVariant.withOpacity(0.7),
                  ),
                ),
              ],
            ),
          );
        }
        return _buildProductListView(context, state);

      case ProductCatalogStatus.failure:
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.error_outline_rounded,
                size: 64,
                color: theme.colorScheme.error.withOpacity(0.8),
              ),
              const SizedBox(height: 16),
              Text(
                'Erro ao carregar produtos',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: theme.colorScheme.error,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Verifique sua conexão com a internet',
                style: TextStyle(
                  fontSize: 14,
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: 24),
              ElevatedButton.icon(
                onPressed: () {
                  context
                      .read<ProductCatalogBloc>()
                      .add(const LoadProducts(refresh: true));
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: theme.colorScheme.primary,
                  foregroundColor: theme.colorScheme.onPrimary,
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                icon: const Icon(Icons.refresh_rounded),
                label: const Text('Tentar novamente'),
              ),
            ],
          ),
        );
    }
  }

  Widget _buildProductListView(
      BuildContext context, ProductCatalogState state) {
    final theme = Theme.of(context);
    // Determinar se deve usar grid ou lista baseado no tamanho da tela
    final screenWidth = MediaQuery.of(context).size.width;
    final useGrid = screenWidth > 600; // Grid para telas maiores que 600px
    final crossAxisCount = screenWidth > 900 ? 3 : 2; // 3 colunas para telas muito largas
    
    return RefreshIndicator(
      onRefresh: () async {
        context
            .read<ProductCatalogBloc>()
            .add(const LoadProducts(refresh: true));
      },
      color: theme.colorScheme.primary,
      backgroundColor: theme.colorScheme.surface,
      child: useGrid
          ? GridView.builder(
              controller: _scrollController,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossAxisCount,
                childAspectRatio: 1.1,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
              ),
              itemCount: state.produtos.length + (state.hasReachedMax ? 0 : 1),
              padding: const EdgeInsets.all(12),
              itemBuilder: (context, index) {
                // Mostrar indicador de carregamento no final da lista
                if (index >= state.produtos.length) {
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: CircularProgressIndicator(
                        color: theme.colorScheme.primary,
                        strokeWidth: 3,
                      ),
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
            )
          : ListView.builder(
              controller: _scrollController,
              itemCount: state.produtos.length + (state.hasReachedMax ? 0 : 1),
              padding: const EdgeInsets.only(bottom: 16, top: 8),
              itemBuilder: (context, index) {
                // Mostrar indicador de carregamento no final da lista
                if (index >= state.produtos.length) {
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      child: CircularProgressIndicator(
                        color: theme.colorScheme.primary,
                        strokeWidth: 3,
                      ),
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
