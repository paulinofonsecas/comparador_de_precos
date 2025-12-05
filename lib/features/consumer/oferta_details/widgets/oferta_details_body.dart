import 'package:comparador_de_precos/data/models/oferta_model.dart';
import 'package:comparador_de_precos/data/models/produto.dart';
import 'package:comparador_de_precos/features/consumer/loja_details/view/loja_details_page.dart'; // Added import
import 'package:comparador_de_precos/features/consumer/oferta_details/bloc/bloc.dart';
import 'package:comparador_de_precos/features/consumer/oferta_details/cubit/get_loja_cubit.dart';
import 'package:comparador_de_precos/features/consumer/oferta_details/cubit/get_more_products_of_market_cubit.dart';
import 'package:comparador_de_precos/features/consumer/oferta_details/widgets/product_info_section.dart';
import 'package:comparador_de_precos/widgets/default_image_widget.dart';
import 'package:comparador_de_precos/widgets/map.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gutter/flutter_gutter.dart';
import 'package:latlong2/latlong.dart';

/// {@template oferta_details_body}
/// Body of the OfertaDetailsPage.
///
/// Add what it does
/// {@endtemplate}
class OfertaDetailsBody extends StatelessWidget {
  /// {@macro oferta_details_body}
  const OfertaDetailsBody({super.key});

  @override
  Widget build(BuildContext context) {
    final oferta = context.read<OfertaDetailsBloc>().oferta;

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DefaultImageWidget(
              imageUrl: oferta.productImage,
              borderRadius: BorderRadius.circular(8),
            ),
            const GutterSmall(),
            ProductInfoSection(oferta: oferta),
            const GutterSmall(),
            const Divider(),
            LojaInfoSection(oferta: oferta),
          ],
        ),
      ),
    );
  }
}

class LojaInfoSection extends StatelessWidget {
  const LojaInfoSection({required this.oferta, super.key});

  final Oferta oferta;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetLojaCubit, GetLojaState>(
      builder: (context, state) {
        if (state is GetLojaInitial) {
          context.read<GetLojaCubit>().getLojaById(oferta.storeId);
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (state is GetLojaLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (state is GetLojaFailure) {
          return Center(
            child: Text(state.error),
          );
        }

        if (state is GetLojaSuccess) {
          final loja = state.loja;

          // Wrapped with GestureDetector
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute<void>(
                  builder: (_) => LojaDetailsPage(lojaId: loja.id),
                ),
              );
            },
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    loja.nome,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const GutterTiny(),
                  const Text('Rua Silva Porto, Cuito, Bié'),
                  const GutterTiny(),
                  const Text('Telefone: 925412030'),
                  const GutterLarge(),
                  const Text(
                    'Localização da loja',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const GutterSmall(),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: MapControllerWidget(
                      localizacao: LatLng(loja.latitude ?? -12.391970665011454,
                          loja.longitude ?? 16.93843950388629),
                      width: double.infinity,
                      initialZoom: 14,
                    ),
                  ),
                  const GutterLarge(),
                  const Text(
                    'Outros produtos da loja',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const GutterSmall(),
                  // horizontal list
                  const ShowMoreProcuctsOfmarket(),
                ],
              ),
            ),
          );
        }

        return const SizedBox.shrink();
      },
    );
  }
}

class ShowMoreProcuctsOfmarket extends StatelessWidget {
  const ShowMoreProcuctsOfmarket({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetMoreProductsOfMarketCubit,
        GetMoreProductsOfMarketState>(
      builder: (context, state) {
        if (state is GetMoreProductsOfMarketInitial) {
          context.read<GetMoreProductsOfMarketCubit>().getMoreProductsOfMarket(
                context.read<OfertaDetailsBloc>().oferta.storeId,
              );

          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (state is GetMoreProductsOfMarketLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (state is GetMoreProductsOfMarketFailure) {
          return const Center(
            child: Text('Erro ao buscar produtos'),
          );
        }

        if (state is GetMoreProductsOfMarketSuccess) {
          final produtos = state.produtos;

          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: produtos.map((produto) {
                return Padding(
                  padding: const EdgeInsets.all(8),
                  child: MiniProductCard(produto: produto),
                );
              }).toList(),
            ),
          );
        }

        return const SizedBox.shrink();
      },
    );
  }
}

class MiniProductCard extends StatelessWidget {
  const MiniProductCard({required this.produto, super.key});

  final Produto produto;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainer,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DefaultImageWidget(
            imageUrl: produto.imagemUrl,
            borderRadius: BorderRadius.circular(8),
            height: 150,
          ),
          const GutterSmall(),
          Text(
            produto.nome,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
            ),
          ),
          if (produto.categoria != null)
            Text(
              produto.categoria?.nome ?? '',
              style: const TextStyle(
                fontWeight: FontWeight.w500,
              ),
            ),
        ],
      ),
    );
  }
}
