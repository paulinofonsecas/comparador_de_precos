import 'dart:developer';

import 'package:comparador_de_precos/app/config/dependencies.dart';
import 'package:comparador_de_precos/data/repositories/produto_with_price.dart';
import 'package:comparador_de_precos/features/logista/logista_produtos_associados/bloc/bloc.dart';
import 'package:comparador_de_precos/features/logista/logista_product_details/cubit/atualizar_preco_cubit.dart';
import 'package:flutter/material.dart';

class AtualizarPriceDialog extends StatefulWidget {
  const AtualizarPriceDialog({
    required this.productWithPrice,
    super.key,
  });

  final ProductWithPrice productWithPrice;

  static Future<void> show(
    BuildContext context,
    ProductWithPrice produtoWithPrice,
  ) async {
    return showDialog<void>(
      context: context,
      builder: (c) => BlocProvider(
        create: (ctx) => AtualizarPrecoCubit(produtoWithPrice, getIt()),
        child: AtualizarPriceDialog(
          productWithPrice: produtoWithPrice,
        ),
      ),
    );
  }

  @override
  State<AtualizarPriceDialog> createState() => _AtualizarPriceDialogState();
}

class _AtualizarPriceDialogState extends State<AtualizarPriceDialog> {
  final priceController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          AtualizarPrecoCubit(widget.productWithPrice, getIt()),
      child: Builder(
        builder: (context) {
          return AlertDialog(
            title: const Text('Atualizar Preço'),
            content: BlocConsumer<AtualizarPrecoCubit, AtualizarPrecoState>(
              listener: (context, state) {
                if (state is AtualizarPrecoSuccess) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Preço atualizado com sucesso!'),
                    ),
                  );

                  Navigator.of(context).pop(true);
                } else if (state is AtualizarPrecoFailure) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content:
                          Text('Erro ao atualizar preço: ${state.message}'),
                    ),
                  );
                }
              },
              builder: (context, state) {
                if (state is AtualizarPrecoLoading) {
                  return const SizedBox.shrink(
                    child: Center(child: CircularProgressIndicator()),
                  );
                }

                return Form(
                  key: _formKey,
                  child: TextFormField(
                    autofocus: true,
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor, insira um preço válido.';
                      }

                      final price = double.tryParse(value);
                      if (price == null || price <= 0) {
                        return 'O preço deve ser um número positivo.';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      setState(() {
                        priceController.text = value;
                      });
                    },
                    decoration: InputDecoration(
                      labelText:
                          'Preço Atual: ${widget.productWithPrice.preco.preco}',
                    ),
                  ),
                );
              },
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Cancelar'),
              ),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState?.validate() ?? false) {
                    context.read<AtualizarPrecoCubit>().atualizarPreco(
                          widget.productWithPrice.produto.id,
                          widget.productWithPrice.preco.profileIdAtualizador ??
                              '',
                          double.parse(
                            priceController.text,
                          ),
                        );
                  } else {
                    log('Formulário inválido');

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Por favor, insira um preço válido.'),
                      ),
                    );
                    return;
                  }
                },
                child: const Text('Atualizar'),
              ),
            ],
          );
        },
      ),
    );
  }
}
