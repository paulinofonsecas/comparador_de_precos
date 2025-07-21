import 'dart:developer';

import 'package:comparador_de_precos/data/models/solicitacao_loja.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SolicitacoesLojaRepository {
  SolicitacoesLojaRepository({
    required this.supabaseClient,
  });

  final SupabaseClient supabaseClient;

  Future<List<SolicitacaoLoja>> getSolicitacoes() async {
    try {
      final response =
          await supabaseClient.from('solicitacoes_lojas').select('*');

      log(response.toString());

      final solicitacoes =
          response.map(SolicitacaoLoja.fromMap);

      return solicitacoes.toList();
    } catch (e) {
      log(e.toString());

      rethrow;
    }
  }
}
