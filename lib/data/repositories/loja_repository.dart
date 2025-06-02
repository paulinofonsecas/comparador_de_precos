import 'package:comparador_de_precos/data/models/loja.dart';
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
}
