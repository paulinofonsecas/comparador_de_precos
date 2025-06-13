import 'dart:developer';

import 'package:comparador_de_precos/data/repositories/produto_with_price.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class ILojistaRepository {
  // retornar todos os produtos cadastrados
  Future<List<ProductWithPrice>> getProdutosAssociados(String logistaId);
  Future<List<ProductWithPrice>> getProdutosEmPromocao(String logistaId);

  Future<void> associarProduto({
    required String productId,
    required String lojistaId,
    required double newPrice,
  });
  Future<void> updatePrice(
    String productId,
    String lojistaId,
    double newPrice,
  );
}

class LojistaRepository implements ILojistaRepository {
  LojistaRepository(this._supabaseClient);

  final SupabaseClient _supabaseClient;

  @override
  Future<List<ProductWithPrice>> getProdutosAssociados(String logistaId) async {
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

      return await ProductWithPrice.fromList(response);
    } catch (e) {
      log(e.toString());
      throw Exception('Erro ao buscar produtos: $e');
    }
  }

  @override
  Future<List<ProductWithPrice>> getProdutosEmPromocao(String logistaId) async {
    try {
      final response = await _supabaseClient
          .from('produtos')
          .select('*, precos:preco_id(*)')
          .eq('logista_id', logistaId)
          .eq('em_promocao', true)
          .order('nome', ascending: true);

      return ProductWithPrice.fromList(response);
    } catch (e) {
      throw Exception('Erro ao buscar produtos em promoção: $e');
    }
  }

  @override
  Future<void> associarProduto({
    required String productId,
    required String lojistaId,
    required double newPrice,
  }) async {
    try {
      final lojaResponse = await _supabaseClient
          .from('lojas')
          .select('id')
          .eq('profile_id_lojista', lojistaId)
          .single();

      final lojaId = lojaResponse['id'] as String;

      await _supabaseClient.from('precos').insert({
        'produto_id': productId,
        'loja_id': lojaId,
        'profile_id_atualizador': lojistaId,
        'preco': newPrice,
      });
    } catch (e) {
      log(e.toString());
      throw Exception('Erro ao associar produto: $e');
    }
  }

  @override
  Future<void> updatePrice(
    String productId,
    String lojistaId,
    double newPrice,
  ) async {
    try {
      final lojaResponse = await _supabaseClient
          .from('lojas')
          .select('id')
          .eq('profile_id_lojista', lojistaId)
          .single();

      final lojaId = lojaResponse['id'] as String;

      await _supabaseClient
          .from('precos')
          .update({
            'preco': newPrice,
            'profile_id_atualizador': lojistaId,
            'updated_at': DateTime.now().toIso8601String(),
          })
          .eq('produto_id', productId)
          .eq('loja_id', lojaId);
    } catch (e) {
      log(e.toString());
      throw Exception('Erro ao atualizar preço: $e');
    }
  }
}
