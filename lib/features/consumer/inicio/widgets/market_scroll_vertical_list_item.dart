import 'package:flutter/material.dart';
import 'package:flutter_gutter/flutter_gutter.dart';

class MarketScrollVerticalListItem extends StatelessWidget {
  const MarketScrollVerticalListItem({
    super.key,
  });

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
                child: Image.network(
                  'https://www.pontotel.com.br/local/wp-content/uploads/2022/05/imagem-corporativa.webp',
                  fit: BoxFit.cover,
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
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Nome da loja',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          'Cuito, rua silva, 123',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        GutterTiny(),
                        Row(
                          spacing: 2,
                          children: [
                            Icon(Icons.star, color: Colors.amber, size: 12),
                            Icon(Icons.star, color: Colors.amber, size: 12),
                            Icon(Icons.star, color: Colors.amber, size: 12),
                            Icon(Icons.star_outline, color: Colors.amber, size: 12),
                            Icon(Icons.star_outline, color: Colors.amber, size: 12),
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
