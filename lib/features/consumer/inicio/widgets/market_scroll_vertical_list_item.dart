import 'package:comparador_de_precos/data/models/loja.dart';
import 'package:comparador_de_precos/widgets/default_image_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gutter/flutter_gutter.dart';

class MarketScrollVerticalListItem extends StatelessWidget {
  const MarketScrollVerticalListItem({
    required this.loja,
    super.key,
  });

  final Loja loja;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Card(
      child: Container(
        width: size.width - 50,
        height: 280,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Flexible(
              flex: 10,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: const DefaultImageWidget(
                  imageUrl:
                      'https://as1.ftcdn.net/v2/jpg/01/27/40/68/1000_F_127406856_K7ABxpHlydS6gFurI9kZsVaR3HsFp4yz.jpg',
                  width: double.infinity,
                ),
              ),
            ),
            Flexible(
              flex: 4,
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          loja.nome,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          loja.endereco ?? 'Endereço não disponível',
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        const GutterTiny(),
                        Row(
                          children: [
                            ...List.generate(
                              loja.classificacaoMedia.floor(),
                              (index) => const Icon(
                                Icons.star,
                                color: Colors.amber,
                                size: 12,
                              ),
                            ),
                            ...List.generate(
                              5 - loja.classificacaoMedia.floor(),
                              (index) => const Icon(
                                Icons.star_outline,
                                color: Colors.amber,
                                size: 12,
                              ),
                            ),
                            const SizedBox(width: 4),
                            Text(
                              '(${loja.numeroAvaliacoes})',
                              style: const TextStyle(fontSize: 10),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Expanded(
                      child: Center(
                        child: TextButton(
                          onPressed: () {},
                          child: const Text('Ver loja'),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
