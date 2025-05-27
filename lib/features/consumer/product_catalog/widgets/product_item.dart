import 'package:comparador_de_precos/data/models/produto.dart';
import 'package:comparador_de_precos/widgets/default_image_widget.dart';
import 'package:flutter/material.dart';

class ProductListItem extends StatelessWidget {
  const ProductListItem({
    required this.produto,
    required this.onTap,
    super.key,
  });

  final Produto produto;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      color: Theme.of(context).colorScheme.surface,
      elevation: .5,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Imagem do produto
              DefaultImageWidget(
                imageUrl: produto.imagemUrl,
                width: 100,
                height: 100,
                borderRadius: BorderRadius.circular(8),
              ),
              const SizedBox(width: 16),
              // Informações do produto
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      produto.nome,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    if (produto.categoria != null) ...[
                      const SizedBox(height: 4),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.blue.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          produto.categoria!.nome,
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.blue,
                          ),
                        ),
                      ),
                    ],
                    const SizedBox(height: 4),
                    Text(
                      'Disponível em 4 lojas',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[700],
                      ),
                    ),
                    const SizedBox(height: 2),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton.icon(
                        icon: const Icon(Icons.chevron_right),
                        iconAlignment: IconAlignment.end,
                        onPressed: onTap,
                        label: const Text(
                          'Ver detalhes',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.blue,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
