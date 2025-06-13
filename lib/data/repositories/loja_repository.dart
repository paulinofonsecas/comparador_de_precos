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
      final Map<String, dynamic> params = {
        'user_lat': userLat,
        'user_lon': userLon,
      };
      
      if (raioMaxKm != null) {
        params['raio_max_km'] = raioMaxKm;
      }
      
      final response = await supabaseClient
          .rpc<List<Map<String, dynamic>>>('buscar_lojas_proximas', params: params);
      
      return response
          .map((json) => LojaComDistancia.fromJson(json))
          .toList();
    } catch (e) {
      throw Exception('Erro ao buscar lojas próximas: $e');
    }
  }
  
  /// Busca todas as lojas
  Future<List<Loja>> getAllLojas() async {
    try {
      final List<Map<String, dynamic>> response = await supabaseClient
          .from('lojas')
          .select()
          .eq('aprovada', true)
          .order('nome');
      
      return response
          .map((json) => Loja.fromJson(json))
          .toList();
    } catch (e) {
      throw Exception('Erro ao buscar todas as lojas: $e');
    }
  }
  
  /// Busca as lojas com melhor classificação
  /// 
  /// [limit] é o número máximo de lojas a retornar (padrão: 10)
  Future<List<Loja>> getTopRatedLojas({int limit = 10}) async {
    try {
      final List<Map<String, dynamic>> response = await supabaseClient
          .from('avaliacoes')
          .select('lojas(*)')
          .order('classificacao', ascending: false)
          .limit(limit);

      final List<Loja> lojas = response
          .map((json) => Loja.fromJson(json['lojas'] as Map<String, dynamic>))
          .where((loja) => loja.aprovada ?? false)
          .toList();
      
      return lojas;
    } catch (e) {
      throw Exception('Erro ao buscar lojas melhores avaliadas: $e');
    }
  }
}
