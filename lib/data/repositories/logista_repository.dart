import 'dart:developer';

import 'package:comparador_de_precos/data/repositories/produto_with_price.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class ILojistaRepository {
  // retornar todos os produtos cadastrados
  Future<List<ProdutoWithPrice>> getProdutosAssociados(String logistaId);
  Future<List<ProdutoWithPrice>> getProdutosEmPromocao(String logistaId);

  Future<void> associarProduto({
    required String productId,
    required String lojaId,
    required String associanteId,
    required double newPrice,
  });
}

class LojistaRepository implements ILojistaRepository {
  LojistaRepository(this._supabaseClient);

  final SupabaseClient _supabaseClient;

  @override
  Future<List<ProdutoWithPrice>> getProdutosAssociados(String logistaId) async {
    try {
      final lojaId = await _supabaseClient
          .from('lojas')
          .select('id')
          .eq('profile_id_lojista', logistaId)
          .single();

      final loja = lojaId['id'] as String;

      final response = await _supabaseClient
          .from('precos')
          .select('*, produtos:produto_id(*, categorias:categoria_id(*))')
          .eq('loja_id', loja);

      return await ProdutoWithPrice.fromList(response);
    } catch (e) {
      log(e.toString());
      throw Exception('Erro ao buscar produtos: $e');
    }
  }

  @override
  Future<List<ProdutoWithPrice>> getProdutosEmPromocao(String logistaId) async {
    try {
      final response = await _supabaseClient
          .from('produtos')
          .select('*, precos:preco_id(*)')
          .eq('logista_id', logistaId)
          .eq('em_promocao', true)
          .order('nome', ascending: true);

      return ProdutoWithPrice.fromList(response);
    } catch (e) {
      throw Exception('Erro ao buscar produtos em promoção: $e');
    }
  }

  @override
  Future<void> associarProduto({
    required String productId,
    required String lojaId,
    required String associanteId,
    required double newPrice,
  }) async {
    try {
      final response = await _supabaseClient.from('precos').insert({
        'produto_id': productId,
        'loja_id': lojaId,
        'associante_id': associanteId,
        'preco': newPrice,
      });

      if (response.error != null) {
        throw Exception('Erro ao associar produto: ${response.error!.message}');
      }
    } catch (e) {
      log(e.toString());
      throw Exception('Erro ao associar produto: $e');
    }
  }
}
