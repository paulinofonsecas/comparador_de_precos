import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uuid/uuid.dart';

import 'package:comparador_de_precos/data/models/avaliacao.dart';

class AvaliacaoRepository {

  AvaliacaoRepository(this._supabaseClient);
  final SupabaseClient _supabaseClient;
  
  /// Adiciona múltiplas avaliações de uma vez
  /// Útil para inserção em lote
  Future<List<Avaliacao>> adicionarMultiplasAvaliacoes(List<Map<String, dynamic>> avaliacoes) async {
    final dataToInsert = avaliacoes.map((avaliacao) {
      final uuid = const Uuid().v4();
      final now = DateTime.now();
      
      return {
        'id': uuid,
        'loja_id': avaliacao['loja_id'],
        'usuario_id': avaliacao['usuario_id'],
        'usuario_nome': avaliacao['usuario_nome'],
        'classificacao': avaliacao['classificacao'],
        'comentario': avaliacao['comentario'],
        'created_at': now.toIso8601String(),
        'updated_at': now.toIso8601String(),
      };
    }).toList();

    await _supabaseClient.from('avaliacoes').insert(dataToInsert);

    return dataToInsert.map(Avaliacao.fromJson).toList();
  }

  Future<List<Avaliacao>> getAvaliacoesByLojaId(String lojaId) async {
    final response = await _supabaseClient
        .from('avaliacoes')
        .select()
        .eq('loja_id', lojaId)
        .order('created_at', ascending: false);

    return response.map(Avaliacao.fromJson).toList();
  }

  Future<double> getClassificacaoMediaByLojaId(String lojaId) async {
    final response = await _supabaseClient
        .rpc<num>('calcular_media_classificacao', params: {'loja_id_param': lojaId});
    
    return response.toDouble();
  }

  Future<int> getNumeroAvaliacoesByLojaId(String lojaId) async {
    final response = await _supabaseClient
        .from('avaliacoes')
        .select('id')
        .eq('loja_id', lojaId);

    return response.length;
  }

  Future<Avaliacao> adicionarAvaliacao({
    required String lojaId,
    required String usuarioId,
    required String usuarioNome,
    required double classificacao,
    String? comentario,
  }) async {
    final uuid = const Uuid().v4();
    final now = DateTime.now();

    final data = {
      'id': uuid,
      'loja_id': lojaId,
      'usuario_id': usuarioId,
      'usuario_nome': usuarioNome,
      'classificacao': classificacao,
      'comentario': comentario,
      'created_at': now.toIso8601String(),
      'updated_at': now.toIso8601String(),
    };

    await _supabaseClient.from('avaliacoes').insert(data);

    return Avaliacao.fromJson(data);
  }

  Future<void> atualizarAvaliacao({
    required String id,
    required double classificacao,
    String? comentario,
  }) async {
    final now = DateTime.now();

    await _supabaseClient.from('avaliacoes').update({
      'classificacao': classificacao,
      'comentario': comentario,
      'updated_at': now.toIso8601String(),
    }).eq('id', id);
  }

  Future<void> excluirAvaliacao(String id) async {
    await _supabaseClient.from('avaliacoes').delete().eq('id', id);
  }
}
