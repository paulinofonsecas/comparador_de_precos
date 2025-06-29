import 'package:comparador_de_precos/data/models/loja.dart';
import 'package:comparador_de_precos/widgets/default_image_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gutter/flutter_gutter.dart';

class LojaListTileWidget extends StatelessWidget {
  const LojaListTileWidget({
    required this.loja,
    this.onTap,
    super.key,
  });

  final Loja loja;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
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
            Padding(
              padding: const EdgeInsets.all(8),
              child: Icon(
                Icons.verified,
                size: 24,
                color: loja.aprovada ?? false
                    ? Theme.of(context)
                        .colorScheme
                        .primary
                    : Theme.of(context)
                        .colorScheme
                        .error,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
