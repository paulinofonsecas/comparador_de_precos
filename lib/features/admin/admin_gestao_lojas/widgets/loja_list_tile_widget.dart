import 'package:comparador_de_precos/data/models/loja.dart';
import 'package:comparador_de_precos/widgets/default_image_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gutter/flutter_gutter.dart';

class LojaListTileWidget extends StatelessWidget {
  const LojaListTileWidget({
    required this.loja,
    super.key,
  });

  final Loja loja;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Row(
        children: [
          DefaultImageWidget(
            imageUrl: loja.logoUrl,
            width: 80,
            height: 80,
            borderRadius: BorderRadius.circular(8),
          ),
          const GutterSmall(),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const GutterTiny(),
                Text(
                  loja.nome,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                Text(
                  loja.descricao ?? 'Descrição não disponível',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const GutterTiny(),
                Text(
                  loja.endereco ?? 'Endereço não disponível',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ),
          const GutterSmall(),
          Icon(
            Icons.arrow_forward_ios,
            size: 16,
            color:
                Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6),
          ),
        ],
      ),
    );
  }
}
