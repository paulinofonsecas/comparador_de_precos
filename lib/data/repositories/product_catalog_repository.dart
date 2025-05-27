import 'package:comparador_de_precos/data/models/categoria.dart';
import 'package:comparador_de_precos/data/models/oferta_model.dart';
import 'package:comparador_de_precos/data/models/produto.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProductCatalogRepository {
  final SupabaseClient _supabaseClient;

  ProductCatalogRepository({SupabaseClient? supabaseClient})
      : _supabaseClient = supabaseClient ?? Supabase.instance.client;

  /// Busca produtos paginados do Supabase
  /// [categoriaId] - ID da categoria para filtrar (opcional)
  /// [page] - Número da página (começa em 0)
  /// [pageSize] - Tamanho da página
  Future<List<Produto>> getProdutos({
    String? categoriaId,
    required int page,
    int pageSize = 10,
  }) async {
    try {
      final start = page * pageSize;
      final end = start + pageSize - 1;

      var query = _supabaseClient
          .from('produtos')
          .select('*, categorias:categoria_id(*)');

      // Aplica filtro de categoria se fornecido
      if (categoriaId != null && categoriaId.isNotEmpty) {
        query = query.eq('categoria_id', categoriaId);
      }

      // Aplica paginação e ordenação
      final response =
          await query.order('nome', ascending: true).range(start, end);

      // Mapeia a resposta para a lista de produtos
      return response.map((item) {
        final produto = Produto.fromMap(item);

        // Adiciona a categoria se estiver presente na resposta
        if (item['categorias'] != null) {
          final categoriaMap = item['categorias'] as Map<String, dynamic>;
          final categoria = Categoria.fromMap(categoriaMap);
          return produto.copyWith(categoria: categoria);
        }

        return produto;
      }).toList();
    } catch (e) {
      throw Exception('Erro ao buscar produtos: $e');
    }
  }

  /// Busca todas as categorias do Supabase
  Future<List<Categoria>> getCategorias() async {
    try {
      final response = await _supabaseClient
          .from('categorias')
          .select()
          .order('nome', ascending: true);

      return response.map(Categoria.fromMap).toList();
    } catch (e) {
      throw Exception('Erro ao buscar categorias: $e');
    }
  }

  /// Busca um produto específico pelo ID
  Future<Produto> getProdutoById(String id) async {
    try {
      final response = await _supabaseClient
          .from('produtos')
          .select('*, categorias:categoria_id(*)')
          .eq('id', id)
          .single();

      final produto = Produto.fromMap(response);

      // Adiciona a categoria se estiver presente na resposta
      if (response['categorias'] != null) {
        final categoriaMap = response['categorias'] as Map<String, dynamic>;
        final categoria = Categoria.fromMap(categoriaMap);
        return produto.copyWith(categoria: categoria);
      }

      return produto;
    } catch (e) {
      throw Exception('Erro ao buscar produto: $e');
    }
  }

  Future<List<OfertaModel>> getSimilarProducts(String productName) async {
    try {
      // ignore: inference_failure_on_function_invocation
      final response = await _supabaseClient.rpc(
        'get_product_store_details_by_name',
        params: {'product_name': productName},
      ) as List<dynamic>;

      final ofertas = response
          .map((item) => OfertaModel.fromMap(item as Map<String, dynamic>))
          .toList();

      return ofertas;
    } catch (e) {
      throw Exception('Erro ao buscar ofertas: $e');
    }
  }
}
