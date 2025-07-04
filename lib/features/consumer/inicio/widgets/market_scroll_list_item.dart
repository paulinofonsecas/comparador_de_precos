import 'package:comparador_de_precos/data/models/loja.dart';
import 'package:comparador_de_precos/features/consumer/loja_details/view/loja_details_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gutter/flutter_gutter.dart';

class MarketScrollListItem extends StatelessWidget {

  const MarketScrollListItem({
    super.key,
    this.loja,
  });
  final Loja? loja;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Card(
      child: InkWell(
        onTap: () {
          if (loja != null) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => LojaDetailsPage(
                  lojaId: loja!.id,
                ),
              ),
            );
          }
        },
        child: Container(
          width: size.width - 50,
          height: 150,
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(
                flex: 8,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    loja?.logoUrl ??
                        'https://as1.ftcdn.net/v2/jpg/01/27/40/68/1000_F_127406856_K7ABxpHlydS6gFurI9kZsVaR3HsFp4yz.jpg',
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: double.infinity,
                    errorBuilder: (context, error, stackTrace) => Container(
                      color: Colors.grey[300],
                      child: const Center(child: Icon(Icons.store, size: 50)),
                    ),
                  ),
                ),
              ),
              const Gutter(),
              Flexible(
                flex: 10,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      loja?.nome ?? 'Nome da loja',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      loja?.endereco ?? 'Endereço não disponível',
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const GutterTiny(),
                    _buildRatingStars(loja?.classificacaoMedia ?? 0,
                        loja?.numeroAvaliacoes ?? 0,),
                    Expanded(
                      child: Center(
                        child: TextButton(
                          onPressed: () {
                            if (loja != null) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => LojaDetailsPage(
                                    lojaId: loja!.id,
                                  ),
                                ),
                              );
                            }
                          },
                          child: const Text('Ver loja'),
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

  Widget _buildRatingStars(double rating, int numAvaliacoes) {
    final fullStars = rating.floor();
    final hasHalfStar = rating - fullStars >= 0.5;
    final emptyStars = 5 - fullStars - (hasHalfStar ? 1 : 0);

    return Row(
      spacing: 2,
      children: [
        ...List.generate(
          fullStars,
          (index) => const Icon(Icons.star, color: Colors.amber, size: 12),
        ),
        if (hasHalfStar)
          const Icon(Icons.star_half, color: Colors.amber, size: 12),
        ...List.generate(
          emptyStars,
          (index) =>
              const Icon(Icons.star_outline, color: Colors.amber, size: 12),
        ),
        Text(
          ' ($numAvaliacoes)',
          style: const TextStyle(fontSize: 10),
        ),
      ],
    );
  }
}
