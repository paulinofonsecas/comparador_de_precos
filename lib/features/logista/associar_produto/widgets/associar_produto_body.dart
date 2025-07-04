import 'dart:developer';

import 'package:comparador_de_precos/app/config/dependencies.dart';
import 'package:comparador_de_precos/data/models/produto.dart';
import 'package:comparador_de_precos/data/models/user_profile.dart';
import 'package:comparador_de_precos/features/logista/associar_produto/cubit/associante_product_cubit.dart';
import 'package:comparador_de_precos/features/logista/associar_produto/cubit/get_all_products_cubit.dart';
import 'package:comparador_de_precos/features/logista/logista_produtos_associados/bloc/bloc.dart';
import 'package:comparador_de_precos/widgets/default_search_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gutter/flutter_gutter.dart';

/// {@template associar_produto_body}
/// Body of the AssociarProdutoPage.
///
/// Add what it does
/// {@endtemplate}
class AssociarProdutoBody extends StatefulWidget {
  /// {@macro associar_produto_body}
  const AssociarProdutoBody({super.key});

  @override
  State<AssociarProdutoBody> createState() => _AssociarProdutoBodyState();
}

class _AssociarProdutoBodyState extends State<AssociarProdutoBody> {
  String? productId;
  double price = 0;
  final userProfile = getIt<UserProfile>();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            SelectProduct(
              value: productId,
              onProductSelected: (String? selectedProductId) {
                setState(() {
                  // Update the productId when a product is selected
                  productId = selectedProductId;
                });
              },
            ),
            const Gutter(),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Preço',
              ),
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor, insira o preço';
                }
                return null;
              },
              onSaved: (value) {
                setState(() {
                  price = double.tryParse(value!) ?? 0;
                });
              },
            ),
            const Gutter(),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate() && productId != null) {
                  _formKey.currentState!.save();
                  context
                      .read<AssocianteProductCubit>()
                      .associar(productId!, userProfile.id, price);
                }
              },
              child: const Text('Associar'),
            ),
          ],
        ),
      ),
    );
  }
}

class SelectProduct extends StatefulWidget {
  const SelectProduct({required this.onProductSelected, super.key, this.value});

  final ValueChanged<String?> onProductSelected;
  final String? value;

  @override
  State<SelectProduct> createState() => _SelectProductState();
}

class _SelectProductState extends State<SelectProduct> {
  Produto? _selectedProduct;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (_selectedProduct != null) ...[
          Text(
            _selectedProduct!.nome,
            style: const TextStyle(fontSize: 16),
          ),
          const Gutter(),
        ],
        ElevatedButton(
          onPressed: () async {
            final produtosCubit = context.read<GetAllProductsCubit>();
            final first20Products = await produtosCubit.first20Products();

            final resultado = await DefaultSearchBottomSheet.show<Produto>(
              // ignore: use_build_context_synchronously
              context: context,
              asyncLoader: (search) async {
                final produtos = await produtosCubit.searchProducts(
                  search: search,
                );

                return produtos;
              },
              items: first20Products,
              itemToString: (item) => item.nome,
              itemSubtitle: (item) => 'Subtítulo de ${item.nome}',
              title: 'Selecione um Lojista',
            );

            if (resultado == null) {
              log('Nenhum lojista selecionado');
              return;
            }

            setState(() {
              _selectedProduct = resultado;
              widget.onProductSelected(_selectedProduct?.id);
            });
          },
          child: const Text('Selecionar Produto'),
        ),
      ],
    );
  }
}
