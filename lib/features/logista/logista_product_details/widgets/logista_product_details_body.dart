import 'package:comparador_de_precos/app/utils/number_format.dart';
import 'package:comparador_de_precos/data/repositories/produto_with_price.dart';
import 'package:comparador_de_precos/features/logista/logista_product_details/cubit/cubit.dart';
import 'package:comparador_de_precos/features/logista/logista_product_details/cubit/product_avaliable_cubit.dart';
import 'package:comparador_de_precos/features/logista/logista_product_details/dialogs/atualizar_price_dialog.dart';
import 'package:comparador_de_precos/features/logista/logista_product_details/dialogs/confirmar_acao_dialog.dart';
import 'package:comparador_de_precos/widgets/default_image_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gutter/flutter_gutter.dart';

/// {@template logista_product_details_body}
/// Body of the LogistaProductDetailsPage.
///
/// Add what it does
/// {@endtemplate}
class LogistaProductDetailsBody extends StatelessWidget {
  /// {@macro logista_product_details_body}
  const LogistaProductDetailsBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LogistaProductDetailsCubit, LogistaProductDetailsState>(
      builder: (context, state) {
        if (state is LogistaProductDetailsLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is LogistaProductDetailsLoaded) {
          return _Body(
            product: state.produto,
          );
        }

        if (state is LogistaProductDetailsError) {
          return const Center(
            child: Text('Ocorreu um erro inesperado.'),
          );
        }

        return const Center(child: Text('Ocorreu um erro inesperado.'));
      },
    );
  }
}

class _Body extends StatelessWidget {
  const _Body({
    required this.product,
  });

  final ProductWithPrice product;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
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
                      product.produto.nome,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const GutterTiny(),
                    Text(
                      product.produto.descricao ?? '',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const GutterTiny(),
                    Text(
                      'Marca: ${product.produto.marca}',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    if (product.produto.categoria != null) ...[
                      const GutterTiny(),
                      Text(
                        'Categoria: '
                        // ignore: lines_longer_than_80_chars
                        '${numberFormat.format(product.produto.categoria?.nome ?? '')}',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                    const GutterTiny(),
                    Text(
                      'Preco: '
                      // ignore: lines_longer_than_80_chars
                      '${numberFormat.format(product.preco.preco)}',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const Gutter(),
                    Text(
                      // ignore: lines_longer_than_80_chars
                      'Disponibilidade: ${product.preco.disponivel ? 'Disponível' : 'Indisponivel'}',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const Gutter(),
          const Divider(),
          const Gutter(),
          Align(
            child: Column(
              children: [
                Text(
                  'Ações sobre o produto',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                TextButton.icon(
                  icon: const Icon(Icons.label_important),
                  label: const Text('Atualizar o preço'),
                  onPressed: () async {
                    final result = await AtualizarPriceDialog.show(
                      context,
                      product,
                    ) as bool?;

                    if (result ?? false) {
                      // ignore: use_build_context_synchronously
                      context
                          .read<LogistaProductDetailsCubit>()
                          .getProdutoDetails(product.produto.id);
                    }
                  },
                ),
                TextButton.icon(
                  icon: Icon(
                    product.preco.disponivel
                        ? Icons.disabled_by_default
                        : Icons.verified,
                  ),
                  label: Text(
                    product.preco.disponivel
                        ? 'Tornar indisponivel'
                        : 'Tornar disponivel',
                  ),
                  onPressed: () async {
                    final result = await ConfirmarAcaoDialog.show(context);

                    if (result ?? false) {
                      await context
                          .read<ProductAvaliableCubit>()
                          .toggleVisibility(
                            product.preco.produtoId,
                            product.preco.lojaId,
                            product.preco.profileIdAtualizador ?? '',
                            product.preco.disponivel,
                          );
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
