import 'package:comparador_de_precos/data/models/loja.dart';
import 'package:flutter/material.dart';

class LojaDetailsBody extends StatelessWidget {
  const LojaDetailsBody({
    super.key,
    required this.loja,
  });

  final Loja loja;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Nome: ${loja.nome}',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 8),
          Text('Descrição: ${loja.descricao}'),
          const SizedBox(height: 8),
          Text('URL: ${loja.logoUrl}'),
        ],
      ),
    );
  }
}