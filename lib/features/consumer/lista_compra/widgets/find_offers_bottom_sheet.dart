
import 'package:comparador_de_precos/data/models/lista_compra.dart';
import 'package:comparador_de_precos/features/consumer/lista_compra/consolidated_offer_page.dart';
import 'package:comparador_de_precos/features/consumer/lista_compra/lowest_price_offer_page.dart';
import 'package:flutter/material.dart';

class FindOffersBottomSheet extends StatelessWidget {
  const FindOffersBottomSheet({required this.listaCompra, super.key});

  final ListaCompra listaCompra;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Encontrar Melhores Ofertas',
            style: Theme.of(context).textTheme.titleLarge,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: () {
              Navigator.pop(context); // Fecha o BottomSheet
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      LowestPriceOfferPage(listaCompra: listaCompra),
                ),
              );
            },
            icon: const Icon(Icons.attach_money),
            label: const Text('Preço mais baixo (várias lojas)'),
          ),
          const SizedBox(height: 12),
          ElevatedButton.icon(
            onPressed: () {
              Navigator.pop(context); // Fecha o BottomSheet
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      ConsolidatedOfferPage(listaCompra: listaCompra),
                ),
              );
            },
            icon: const Icon(Icons.store),
            label: const Text('Aglutinar produtos por loja'),
          ),
        ],
      ),
    );
  }
}
