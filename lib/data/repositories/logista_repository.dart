import 'dart:developer';

import 'package:comparador_de_precos/data/models/user_profile.dart';
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

  Future<void> updatePromotionPrice(
    String productId,
    String lojistaId,
    double? newPrice,
  );

  Future<ProductWithPrice?> getProdutosAssociado(
    String produtoId,
    String logistaId,
  );

  Future<bool> toggleVisibility(
      String productId, String lojaId, String profileId,
      {required bool previusVisibity});
  Future<UserProfile?> getProfile(String profileId);
}

class SupabaseLojistaRepository implements ILojistaRepository {
  SupabaseLojistaRepository(this._supabaseClient);

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
        'data_atualizacao': DateTime.now().toIso8601String(),
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
            'data_atualizacao': DateTime.now().toIso8601String(),
          })
          .eq('produto_id', productId)
          .eq('loja_id', lojaId);
    } catch (e) {
      log(e.toString());
      throw Exception('Erro ao atualizar preço: $e');
    }
  }

  @override
  Future<void> updatePromotionPrice(
    String productId,
    String lojistaId,
    double? newPrice,
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
            'preco_promocional': newPrice,
            'profile_id_atualizador': lojistaId,
            'updated_at': DateTime.now().toIso8601String(),
            'data_atualizacao': DateTime.now().toIso8601String(),
          })
          .eq('produto_id', productId)
          .eq('loja_id', lojaId);
    } catch (e) {
      log(e.toString());
      throw Exception('Erro ao atualizar preço: $e');
    }
  }

  @override
  Future<ProductWithPrice?> getProdutosAssociado(
    String produtoId,
    String logistaId,
  ) async {
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
          .eq('loja_id', loja)
          .eq('produto_id', produtoId)
          .single();

      final pwp = ProductWithPrice.fromMap(response);

      return pwp;
    } catch (e) {
      log(e.toString());
      throw Exception('Erro ao buscar produtos: $e');
    }
  }

  @override
  Future<bool> toggleVisibility(
    String productId,
    String lojaId,
    String profileId, {
    required bool previusVisibity,
  }) async {
    try {
      await _supabaseClient
          .from('precos')
          .update({
            'disponivel': !previusVisibity,
            'updated_at': DateTime.now().toIso8601String(),
            'profile_id_atualizador': profileId,
          })
          .eq('loja_id', lojaId)
          .eq('produto_id', productId);

      return !previusVisibity;
    } catch (e) {
      log(e.toString());
      throw Exception('Erro ao buscar produtos: $e');
    }
  }

  Future<List<UserProfile>> getLojistas(String search) async {
    try {
      final response = await _supabaseClient
          .from('profiles')
          .select()
          .eq('tipo_usuario', 'lojista')
          .ilike('nome_completo', '%$search%')
          .limit(20);

      if (response.isEmpty) {
        return [];
      }

      return response.map(UserProfile.fromMap).toList();
    } catch (e) {
      log(e.toString());
      throw Exception('Erro ao buscar lojistas: $e');
    }
  }

  @override
  Future<UserProfile?> getProfile(String profileId) async {
    try {
      final response = await _supabaseClient
          .from('profiles')
          .select()
          .eq('user_id', profileId)
          .single();

      return UserProfile.fromMap(response);
    } catch (e) {
      log(e.toString());
      throw Exception('Erro ao buscar perfil do lojista: $e');
    }
  }
}
