import 'package:comparador_de_precos/data/repositories/product_catalog_repository.dart';
import 'package:comparador_de_precos/features/consumer/product_catalog/bloc/product_catalog_bloc.dart';
import 'package:comparador_de_precos/features/consumer/product_catalog/bloc/product_catalog_event.dart';
import 'package:comparador_de_precos/features/consumer/product_catalog/widgets/product_catalog_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductCatalogPage extends StatelessWidget {
  const ProductCatalogPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProductCatalogBloc(
        repository: ProductCatalogRepository(),
      )
        ..add(LoadCategories())
        ..add(const LoadProducts()),
      child: Builder(
        builder: (context) {
          final theme = Theme.of(context);
          
          return Scaffold(
            appBar: AppBar(
              title: Text(
                'Catálogo de Produtos',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: theme.colorScheme.onSurface,
                ),
              ),
              centerTitle: true,
              elevation: 0,
              backgroundColor: theme.colorScheme.surface,
              actions: [
                IconButton(
                  icon: Icon(
                    Icons.refresh_rounded,
                    color: theme.colorScheme.primary,
                  ),
                  onPressed: () {
                    context
                        .read<ProductCatalogBloc>()
                        .add(const LoadProducts(refresh: true));
                  },
                ),
                IconButton(
                  icon: Icon(
                    Icons.filter_list_rounded,
                    color: theme.colorScheme.primary,
                  ),
                  onPressed: () {
                    // Implementar filtragem avançada no futuro
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Filtros avançados em breve!'),
                        duration: Duration(seconds: 1),
                      ),
                    );
                  },
                ),
                const SizedBox(width: 8),
              ],
            ),
            body: const ProductCatalogView(),
          );
        },
      ),
    );
  }
}

class ProductCatalogView extends StatelessWidget {
  const ProductCatalogView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.background,
      child: const ProductCatalogBody(),
    );
  }
}
