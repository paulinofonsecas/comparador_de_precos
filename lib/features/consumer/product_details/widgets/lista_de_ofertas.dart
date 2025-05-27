import 'package:comparador_de_precos/data/models/produto.dart';
import 'package:comparador_de_precos/features/consumer/product_details/cubit/get_similar_products_cubit.dart';
import 'package:comparador_de_precos/features/consumer/product_details/widgets/oferta_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ListaDeOfertas extends StatelessWidget {
  const ListaDeOfertas({
    required this.produto,
    super.key,
  });

  final Produto produto;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetSimilarProductsCubit, GetSimilarProductsState>(
      builder: (context, state) {
        if (state is GetSimilarProductsInitial) {
          context
              .read<GetSimilarProductsCubit>()
              .getSimilarProducts(produto.nome);

          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (state is GetSimilarProductsLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (state is GetSimilarProductsSuccess) {
          final ofertas = state.similarProducts;

          if (ofertas.isEmpty) {
            return const Center(
              child: Text('Nenhuma oferta encontrada'),
            );
          }

          return Column(
            children: List.generate(
              ofertas.length,
              (index) => OfertaItem(
                oferta: ofertas.elementAt(index),
                onTap: () {},
              ),
            ),
          );
        }
        if (state is GetSimilarProductsFailure) {
          return const Center(
            child: Text('Erro ao buscar ofertas'),
          );
        }

        return const SizedBox.shrink();
      },
    );
  }
}
