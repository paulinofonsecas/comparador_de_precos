import 'package:comparador_de_precos/data/models/produto.dart';
import 'package:comparador_de_precos/features/consumer/product_details/widgets/lista_de_ofertas.dart';
import 'package:comparador_de_precos/widgets/default_image_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gutter/flutter_gutter.dart';
import 'package:star_rating/star_rating.dart';

/// {@template product_details_body}
/// Body of the ProductDetailsPage.
///
/// Add what it does
/// {@endtemplate}
class ProductDetailsBody extends StatelessWidget {
  /// {@macro product_details_body}
  const ProductDetailsBody({required this.produto, super.key});

  final Produto produto;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DefaultImageWidget(
              // imageUrl: produto.imagemUrl,
              imageUrl:
                  'https://www.pontotel.com.br/local/wp-content/uploads/2022/05/imagem-corporativa.webp',
              borderRadius: BorderRadius.circular(8),
            ),
            const GutterTiny(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        produto.nome,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const StarRating(
                        rating: 3.5,
                        length: 5,
                        color: Colors.amber,
                        starSize: 18,
                      ),
                      const GutterTiny(),
                      const Text(
                        'Menor preço: 1.250,00 Kz',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.favorite,
                      color: Colors.red,
                    ),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
            const Gutter(),
            const Divider(),
            const Gutter(),
            Row(
              children: [
                const Text(
                  'Ofertas',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                TextButton.icon(
                  iconAlignment: IconAlignment.end,
                  icon: const Icon(
                    Icons.filter_list,
                    size: 20,
                  ),
                  label: const Text('Ordenar'),
                  onPressed: () {},
                ),
              ],
            ),
            const GutterTiny(),
            ListaDeOfertas(produto: produto),
          ],
        ),
      ),
    );
  }
}
