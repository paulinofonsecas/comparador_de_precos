import 'package:comparador_de_precos/app/utils/number_format.dart';
import 'package:comparador_de_precos/data/models/oferta_model.dart';
import 'package:comparador_de_precos/features/consumer/oferta_details/bloc/bloc.dart';
import 'package:comparador_de_precos/features/consumer/oferta_details/cubit/get_product_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gutter/flutter_gutter.dart';
import 'package:star_rating/star_rating.dart';
import 'package:timeago/timeago.dart' as timeago;

class ProductInfoSection extends StatelessWidget {
  const ProductInfoSection({
    required this.oferta,
    super.key,
  });

  final OfertaModel oferta;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetProductCubit, GetProductState>(
      builder: (context, state) {
        if (state is GetProductInitial) {
          context.read<GetProductCubit>().getProduct(oferta.productId);
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (state is GetProductLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (state is GetProductSuccess) {
          final produto = state.produto;

          return Padding(
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
                    if (produto.precoMinimo != null) ...[
                      Row(
                        spacing: 8,
                        children: [
                          Text(
                            numberFormat.format(oferta.price),
                            style: oferta.promotionPrice != null
                                ? TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    decoration: TextDecoration.lineThrough,
                                    decorationColor:
                                        Colors.red.withValues(alpha: 0.8),
                                    decorationThickness: 2,
                                  )
                                : null,
                          ),
                          if (oferta.promotionPrice != null) ...[
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 6,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: Colors.green.withValues(alpha: 0.8),
                              ),
                              child: RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: numberFormat
                                          .format(oferta.promotionPrice),
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onPrimary,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                          if (oferta.lastPriceUpdate != null) ...[
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 4,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: Theme.of(context)
                                    .colorScheme
                                    .primaryContainer,
                              ),
                              child: Text(
                                'Há ${timeago.format(
                                  oferta.lastPriceUpdate!,
                                  locale: 'pt_BR_short',
                                )}',
                                style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ],
                      ),
                    ],
                  ],
                ),
              ],
            ),
          );
        }

        return const SizedBox.shrink();
      },
    );
  }
}
