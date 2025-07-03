import 'dart:developer';

import 'package:supabase_flutter/supabase_flutter.dart';

class SolicitacoesLojaRepository {
  SolicitacoesLojaRepository({
    required this.supabaseClient,
  });

  final SupabaseClient supabaseClient;

  Future<List<Map<String, dynamic>>> getSolicitacoes() async {
    try {
      final response = await supabaseClient
          .from('solicitacoes_lojas')
          .select('*, file_paths:documentos_solicitacao_loja(*)');

      log(response.toString());

      return [];
    } catch (e) {
      throw Exception('Failed to load solicitacoes: $e');
    }
  }
}
