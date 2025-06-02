import 'package:comparador_de_precos/data/models/loja.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gutter/flutter_gutter.dart';

class LojaDetailsBody extends StatelessWidget {
  const LojaDetailsBody({super.key, required this.loja});

  final Loja loja;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            loja.nome,
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const GutterSmall(),
          // Assuming Loja model has an 'endereco' field
          if (loja.endereco != null) Text('Endereço: ${loja.endereco}'),
          const GutterSmall(),
           // Assuming Loja model has a 'telefone' field
          if (loja.telefoneContato != null) Text('Telefone: ${loja.telefoneContato}'),
          // Add more store details here
          // e.g., list of products, opening hours, etc.
        ],
      ),
    );
  }
}
