import 'package:comparador_de_precos/data/models/produto.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SearchProductRepository {
  SearchProductRepository({
    SupabaseClient? supabaseClient,
  }) : _supabaseClient = supabaseClient ?? Supabase.instance.client;

  final SupabaseClient _supabaseClient;

  Future<List<Produto>> searchProducts(String query) async {
    try {
      final response = await _supabaseClient
          .from('produtos')
          .select('*, categorias:categoria_id(*)')
          .ilike('nome', '%$query%')
          .order('nome', ascending: true);

      return response.map(Produto.fromMap).toList();
    } catch (e) {
      throw Exception('Erro ao buscar produtos: $e');
    }
  }
}
