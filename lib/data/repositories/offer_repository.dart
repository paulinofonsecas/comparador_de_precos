import 'dart:developer';

import 'package:comparador_de_precos/data/models/oferta_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class OfferRepository {
  final SupabaseClient _supabase = Supabase.instance.client;

  Future<List<Oferta>> getOffersForProduct(String productId) async {
    try {
      final response = await _supabase
          .from('precos')
          .select('*, produtos:produto_id(*), lojas:loja_id(*)')
          .eq('produto_id', productId);

      final ofertas = response.map((e) {
        return Oferta(
          id: e['id'] as String,
          productName: e['produtos']['nome'] as String,
          productImage: e['produtos']['imagem_url'] as String,
          productId: productId,
          storeId: e['lojas']['id'] as String,
          storeName: e['lojas']['nome'] as String,
          storeLocation: e['lojas']['endereco'] as String,
          price: e['preco'] as double,
          lastPriceUpdate: e['updated_at'] != null
              ? DateTime.parse(e['updated_at'] as String)
              : null,
          promotionPrice: e['preco_promocional'] != null
              ? e['preco_promocional'] as double
              : null,
        );
      }).toList()
        ..sort((a, b) => a.price.compareTo(b.price))
        ..reversed;

      return ofertas;
    } catch (e) {
      print('Erro ao buscar ofertas: $e');
      rethrow;
    }
  }
}
