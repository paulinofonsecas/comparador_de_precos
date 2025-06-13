import 'package:comparador_de_precos/app/config/dependencies.dart';
import 'package:comparador_de_precos/features/consumer/product_details/bloc/bloc.dart';
import 'package:comparador_de_precos/features/consumer/product_details/cubit/favorite_cubit.dart';
import 'package:comparador_de_precos/features/consumer/product_details/cubit/get_similar_products_cubit.dart';
import 'package:comparador_de_precos/features/consumer/product_details/widgets/product_details_body.dart';
import 'package:flutter/material.dart';

/// {@template product_details_page}
/// A description for ProductDetailsPage
/// {@endtemplate}
class ProductDetailsPage extends StatelessWidget {
  /// {@macro product_details_page}
  const ProductDetailsPage({required this.productId, super.key});

  final String productId;

  /// The static route for ProductDetailsPage
  static Route<dynamic> route(String productId) {
    return MaterialPageRoute<dynamic>(
      builder: (_) => ProductDetailsPage(productId: productId),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ProductDetailsBloc(repository: getIt())
            ..add(LoadProductDetailsEvent(productId)),
        ),
        BlocProvider(
          create: (context) => GetSimilarProductsCubit(getIt()),
        ),
        BlocProvider(
          create: (context) => FavoriteCubit(repository: getIt())
            ..checkFavoriteStatus(productId),
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Detalhes do Produto'),
        ),
        body: const ProductDetailsView(),
      ),
    );
  }
}

/// {@template product_details_view}
/// Displays the Body of ProductDetailsView
/// {@endtemplate}
class ProductDetailsView extends StatelessWidget {
  /// {@macro product_details_view}
  const ProductDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductDetailsBloc, ProductDetailsState>(
      builder: (context, state) {
        if (state is ProductDetailsLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is ProductDetailsError) {
          return const Center(
            child: Text(
              'Erro ao carregar produto',
              style: TextStyle(color: Colors.red),
            ),
          );
        }

        if (state is ProductDetailsLoaded) {
          return ProductDetailsBody(produto: state.produto);
        }

        return const Center(child: Text('Erro ao carregar produto'));
      },
    );
  }
}
