import 'package:comparador_de_precos/app/config/dependencies.dart';
import 'package:comparador_de_precos/data/models/user_profile.dart';
import 'package:comparador_de_precos/features/logista/associar_produto/cubit/associante_product_cubit.dart';
import 'package:comparador_de_precos/features/logista/associar_produto/cubit/get_all_products_cubit.dart';
import 'package:comparador_de_precos/features/logista/logista_produtos_associados/bloc/bloc.dart';
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

class SelectProduct extends StatelessWidget {
  const SelectProduct({required this.onProductSelected, super.key, this.value});

  final ValueChanged<String?> onProductSelected;
  final String? value;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      decoration: const InputDecoration(
        labelText: 'Selecione um produto',
      ),
      value: value,
      items: context
          .watch<GetAllProductsCubit>()
          .state
          .produtos
          .map(
            (product) => DropdownMenuItem<String>(
              value: product.id,
              child: Text(product.nome),
              onTap: () {
                onProductSelected(product.id);
              },
            ),
          )
          .toList(),
      onChanged: onProductSelected,
      validator: (value) {
        if (value == null) {
          return 'Por favor, selecione um produto';
        }
        return null;
      },
    );
  }
}
