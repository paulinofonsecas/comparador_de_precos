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
          return Scaffold(
            appBar: AppBar(
              title: const Text('Catálogo de Produtos'),
              actions: [
                IconButton(
                  icon: const Icon(Icons.refresh),
                  onPressed: () {
                    context
                        .read<ProductCatalogBloc>()
                        .add(const LoadProducts(refresh: true));
                  },
                ),
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
    return const ProductCatalogBody();
  }
}
