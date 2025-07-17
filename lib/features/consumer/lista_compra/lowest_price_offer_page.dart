import 'package:comparador_de_precos/app/utils/number_format.dart';
import 'package:comparador_de_precos/data/models/lista_compra.dart';
import 'package:comparador_de_precos/data/models/oferta_model.dart';
import 'package:comparador_de_precos/data/repositories/offer_repository.dart';
import 'package:comparador_de_precos/features/consumer/oferta_details/view/oferta_details_page.dart';
import 'package:flutter/material.dart';

class LowestPriceOfferPage extends StatefulWidget {
  const LowestPriceOfferPage({required this.listaCompra, super.key});

  final ListaCompra listaCompra;

  @override
  State<LowestPriceOfferPage> createState() => _LowestPriceOfferPageState();
}

class _LowestPriceOfferPageState extends State<LowestPriceOfferPage> {
  final OfferRepository _offerRepository = OfferRepository();
  late Future<Map<String, Oferta?>> _bestOffersFuture;

  @override
  void initState() {
    super.initState();
    _bestOffersFuture = _findBestOffers();
  }

  Future<Map<String, Oferta?>> _findBestOffers() async {
    final bestOffers = <String, Oferta?>{};
    for (final item in widget.listaCompra.itens) {
      if (item.produto != null) {
        final offers =
            await _offerRepository.getOffersForProduct(item.produto!.id);
        if (offers.isNotEmpty) {
          offers.sort((a, b) => a.price.compareTo(b.price));
          bestOffers[item.produto!.id] = offers.first;
        }
      }
    }
    return bestOffers;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ofertas da lista'),
      ),
      body: FutureBuilder<Map<String, Oferta?>>(
        future: _bestOffersFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return const Center(child: Text('Erro ao buscar ofertas'));
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Nenhuma oferta encontrada'));
          }

          final bestOffers = snapshot.data!;

          return ListView.builder(
            itemCount: widget.listaCompra.itens.length,
            itemBuilder: (context, index) {
              final item = widget.listaCompra.itens[index];
              final bestOffer = bestOffers[item.produto?.id];

              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: InkWell(
                  onTap: () {
                    if (bestOffer != null) {
                      OfertaDetailsBottomSheet.show(
                        context,
                        oferta: bestOffer,
                      );
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item.produto?.nome ?? 'Produto desconhecido',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        if (bestOffer != null) ...[
                          Text(
                            'Melhor oferta: ${numberFormat.format(bestOffer.price)} ',
                            style: const TextStyle(fontSize: 16),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Loja: ${bestOffer.storeName}',
                            style: const TextStyle(fontSize: 16),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Localização: ${bestOffer.storeLocation}',
                            style: const TextStyle(fontSize: 16),
                          ),
                        ] else
                          const Text(
                            'Nenhuma oferta encontrada',
                            style: TextStyle(fontSize: 16),
                          ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
