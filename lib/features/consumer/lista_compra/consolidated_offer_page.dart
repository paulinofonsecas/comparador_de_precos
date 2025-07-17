import 'package:comparador_de_precos/data/models/lista_compra.dart';
import 'package:comparador_de_precos/data/models/oferta_model.dart';
import 'package:comparador_de_precos/data/repositories/offer_repository.dart';
import 'package:flutter/material.dart';

class ConsolidatedOfferPage extends StatefulWidget {
  const ConsolidatedOfferPage({required this.listaCompra, super.key});

  final ListaCompra listaCompra;

  @override
  State<ConsolidatedOfferPage> createState() => _ConsolidatedOfferPageState();
}

class _ConsolidatedOfferPageState extends State<ConsolidatedOfferPage> {
  final OfferRepository _offerRepository = OfferRepository();
  late Future<Map<String, List<Oferta>>> _consolidatedOffersFuture;

  @override
  void initState() {
    super.initState();
    _consolidatedOffersFuture = _findConsolidatedOffers();
  }

  Future<Map<String, List<Oferta>>> _findConsolidatedOffers() async {
    final allOffers = <Oferta>[];
    for (final item in widget.listaCompra.itens) {
      if (item.produto != null) {
        final offers = await _offerRepository.getOffersForProduct(item.produto!.id);
        allOffers.addAll(offers);
      }
    }

    final consolidatedOffers = <String, List<Oferta>>{};
    for (final offer in allOffers) {
      if (!consolidatedOffers.containsKey(offer.storeId)) {
        consolidatedOffers[offer.storeId] = [];
      }
      consolidatedOffers[offer.storeId]!.add(offer);
    }

    // Ordena as lojas pela quantidade de itens encontrados
    final sortedStores = consolidatedOffers.entries.toList()
      ..sort((a, b) => b.value.length.compareTo(a.value.length));

    return Map.fromEntries(sortedStores);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Compras Consolidadas por Loja'),
      ),
      body: FutureBuilder<Map<String, List<Oferta>>>(
        future: _consolidatedOffersFuture,
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

          final consolidatedOffers = snapshot.data!;

          return ListView.builder(
            itemCount: consolidatedOffers.length,
            itemBuilder: (context, index) {
              final lojaId = consolidatedOffers.keys.elementAt(index);
              final offers = consolidatedOffers[lojaId]!;
              final storeName = offers.first.storeName;

              return Card(
                margin: const EdgeInsets.all(8.0),
                child: ExpansionTile(
                  title: Text('$storeName (${offers.length} itens)'),
                  children: offers.map((offer) {
                    final product = widget.listaCompra.itens
                        .firstWhere((item) => item.produto?.id == offer.productId)
                        .produto;
                    return ListTile(
                      title: Text(product?.nome ?? 'Produto desconhecido'),
                      subtitle: Text('Preço: R\$ ${offer.price.toStringAsFixed(2)}'),
                    );
                  }).toList(),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
