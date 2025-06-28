import 'package:comparador_de_precos/data/models/loja.dart';
import 'package:comparador_de_precos/data/models/loja_com_distancia.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class LojaRepository {
  LojaRepository({required this.supabaseClient});

  final SupabaseClient supabaseClient;

  Future<Loja?> getLojaById(String id) async {
    try {
      final response =
          await supabaseClient.from('lojas').select().eq('id', id).single();

      return Loja.fromJson(response);
    } catch (e) {
      throw Exception('Erro ao buscar loja: $e');
    }
  }

  /// Busca todas as lojas ordenadas por proximidade
  ///
  /// [userLat] e [userLon] são as coordenadas do usuário
  /// [raioMaxKm] é o raio máximo em km (opcional)
  Future<List<LojaComDistancia>> getLojasProximas({
    required double userLat,
    required double userLon,
    double? raioMaxKm,
  }) async {
    try {
      final params = <String, dynamic>{
        'user_lat': userLat,
        'user_lon': userLon,
      };

      if (raioMaxKm != null) {
        params['raio_max_km'] = raioMaxKm;
      }

      final response = await supabaseClient.rpc<List<Map<String, dynamic>>>(
          'buscar_lojas_proximas',
          params: params);

      return response.map(LojaComDistancia.fromJson).toList();
    } catch (e) {
      throw Exception('Erro ao buscar lojas próximas: $e');
    }
  }

  /// Busca todas as lojas
  Future<List<Loja>> getAllLojas() async {
    try {
      final response = await supabaseClient
          .from('lojas')
          .select()
          .eq('aprovada', true)
          .order('nome');

      return response.map(Loja.fromJson).toList();
    } catch (e) {
      throw Exception('Erro ao buscar todas as lojas: $e');
    }
  }

  /// Busca as lojas com melhor classificação
  ///
  /// [limit] é o número máximo de lojas a retornar (padrão: 10)
  Future<List<Loja>> getTopRatedLojas({int limit = 10}) async {
    try {
      final response = await supabaseClient
          .from('avaliacoes')
          .select('lojas(*)')
          .order('classificacao', ascending: false)
          .limit(limit);

      final lojas = response
          .map((json) => Loja.fromJson(json['lojas'] as Map<String, dynamic>))
          .where((loja) => loja.aprovada ?? false)
          .toList();

      return lojas;
    } catch (e) {
      throw Exception('Erro ao buscar lojas melhores avaliadas: $e');
    }
  }

  /// Busca lojas por nome
  /// /// [nome] é o nome ou parte do nome da loja
  Future<List<Loja>> searchLojas(String nome) async {
    try {
      final response = await supabaseClient
          .from('lojas')
          .select()
          .ilike('nome', '%$nome%')
          .order('nome');

      return response.map(Loja.fromJson).toList();
    } catch (e) {
      throw Exception('Erro ao buscar lojas: $e');
    }
  }

  /// get lojas with pagination
  /// [page] é o número da página (começando de 1)
  /// [limit] é o número de lojas por página (padrão: 10
  /// [orderBy] é o campo para ordenar as lojas (padrão: 'nome')
  Future<List<Loja>> getLojas({
    int page = 1,
    int limit = 10,
    String orderBy = 'nome',
  }) async {
    try {
      final response = await supabaseClient
          .from('lojas')
          .select()
          .range((page - 1) * limit, page * limit - 1)
          .order(orderBy);

      return response.map(Loja.fromJson).toList();
    } catch (e) {
      throw Exception('Erro ao buscar lojas: $e');
    }
  }

  /// get informações gerais das lojas
  Future<Map<String, int>> getLojasInfo() async {
    try {
      final totalLojasResponse = await supabaseClient
          .from('lojas')
          .select()
          .eq('aprovada', true)
          .count();

      final lojasParaAvaliarResponse = await supabaseClient
          .from('lojas')
          .select()
          .eq('aprovada', false)
          .count();

      // Retorna um mapa com as informações
      // totalLojas: total de lojas aprovadas
      // lojasParaAvaliar: total de lojas pendentes de avaliação
      // Se não houver lojas pendentes, retorna 0
      return {
        'totalLojas': totalLojasResponse.count,
        'lojasParaAvaliar': lojasParaAvaliarResponse.count,
      };
    } catch (e) {
      throw Exception('Erro ao buscar informações das lojas: $e');
    }
  }

  Future<void> desaprovarLoja(String lojaId) async {
    try {
      await supabaseClient
          .from('lojas')
          .update({'aprovada': false}).eq('id', lojaId);
    } catch (e) {
      throw Exception('Erro ao desaprovar loja: $e');
    }
  }

  Future<void> aprovarLoja(String lojaId) async {
    try {
      await supabaseClient
          .from('lojas')
          .update({'aprovada': true}).eq('id', lojaId);
    } catch (e) {
      throw Exception('Erro ao aprovar loja: $e');
    }
  }
}
