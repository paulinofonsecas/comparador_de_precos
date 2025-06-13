import 'package:comparador_de_precos/data/models/lista_compra.dart';
import 'package:comparador_de_precos/data/models/produto.dart';
import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uuid/uuid.dart';

class ListaCompraRepository {
  ListaCompraRepository();

  final supabase = Supabase.instance.client;
  final tableName = 'listas_de_compras';

  // Obter todas as listas de compras do usuário
  Future<List<ListaCompra>> getListasCompra(String userId) async {
    try {
      final response =
          await supabase.from(tableName).select().eq('user_id', userId);

      final listaIds = response.map((item) => item['id'] as String).toList();

      final listItems = await supabase
          .from('itens_lista_de_compras')
          .select('*, produto:produto_id(*)')
          .inFilter('lista_de_compras_id', listaIds);

      final itensPreparados = listItems.map(ItemListaCompra.fromMap).toList();

      final listas = response
          .map(ListaCompra.fromMap)
          .map((lista) => lista.copyWith(itens: itensPreparados))
          .toList();

      return listas;
    } catch (e) {
      debugPrint('Erro ao buscar listas de compra: $e');
      rethrow;
    }
  }

  // Obter uma lista de compras específica
  Future<ListaCompra?> getListaCompra(String listaId) async {
    try {
      final userId = Supabase.instance.client.auth.currentUser!.id;
      final response = await supabase
          .from(tableName)
          .select()
          .eq('user_id', userId)
          .eq('id', listaId);

      final listItems = await supabase
          .from('itens_lista_de_compras')
          .select('*, produto:produto_id(*)')
          .eq('lista_de_compras_id', listaId);

      var listaCompra =
          response.map(ListaCompra.fromMap).toList().firstOrNull;

      if (listaCompra != null) {
        listaCompra = listaCompra.copyWith(
          itens: listItems.map(ItemListaCompra.fromMap).toList(),
        );
      }

      return listaCompra;
    } catch (e) {
      debugPrint('Erro ao buscar lista de compra: $e');
      return null;
    }
  }

  // Criar uma nova lista de compras
  Future<ListaCompra> criarListaCompra({
    required String nome,
    String? descricao,
  }) async {
    try {
      final userId = Supabase.instance.client.auth.currentUser!.id;

      final novaLista = ListaCompra(
        id: const Uuid().v4(),
        nome: nome,
        userId: userId,
        dataCriacao: DateTime.now(),
        descricao: descricao,
        itens: [],
      );

      await supabase.from(tableName).insert(novaLista.toMap());

      return novaLista;
    } catch (e) {
      debugPrint('Erro ao criar lista de compra: $e');
      rethrow;
    }
  }

  // Atualizar uma lista de compras existente
  Future<ListaCompra> atualizarListaCompra(ListaCompra lista) async {
    try {
      final userId = Supabase.instance.client.auth.currentUser!.id;
      await supabase
          .from(tableName)
          .update(lista.toMap())
          .eq('user_id', userId)
          .eq('id', lista.id);

      return lista;
    } catch (e) {
      debugPrint('Erro ao atualizar lista de compra: $e');
      rethrow;
    }
  }

  // Excluir uma lista de compras
  Future<bool> excluirListaCompra(String listaId) async {
    try {
      final userId = Supabase.instance.client.auth.currentUser!.id;
      await supabase
          .from(tableName)
          .delete()
          .eq('user_id', userId)
          .eq('id', listaId);

      return true;
    } catch (e) {
      debugPrint('Erro ao excluir lista de compra: $e');
      return false;
    }
  }

  // Adicionar um item à lista de compras
  Future<ListaCompra> adicionarItemListaCompra({
    required String listaId,
    required String produtoId,
    required int quantidade,
    String? observacao,
    Produto? produto,
  }) async {
    try {
      final lista = await getListaCompra(listaId);
      if (lista == null) {
        throw Exception('Lista de compra não encontrada');
      }

      final novaLista = lista.copyWith(
        itens: [
          ...lista.itens,
          ItemListaCompra(
            id: const Uuid().v4(),
            produtoId: produtoId,
            quantidade: quantidade,
            observacao: observacao,
            produto: produto,
          )
        ],
      );

      await supabase.from('itens_lista_de_compras').insert({
        'lista_de_compras_id': listaId,
        'produto_id': produtoId,
        'quantidade': quantidade,
        'observacao': observacao,
      });

      await supabase
          .from(tableName)
          .update(novaLista.toMap())
          .eq('id', lista.id);

      return novaLista;
    } catch (e) {
      debugPrint('Erro ao adicionar item à lista de compra: $e');
      rethrow;
    }
  }

  // Atualizar um item da lista de compras
  Future<ListaCompra> atualizarItemListaCompra({
    required String listaId,
    required ItemListaCompra item,
  }) async {
    try {
      final userId = Supabase.instance.client.auth.currentUser!.id;
      final lista = await getListaCompra(listaId);
      if (lista == null) {
        throw Exception('Lista de compra não encontrada');
      }

      final novaLista = lista.copyWith(
        itens: lista.itens.map((i) => i.id == item.id ? item : i).toList(),
      );

      await supabase
          .from(tableName)
          .update(novaLista.toMap())
          .eq('user_id', userId)
          .eq('id', lista.id);

      return novaLista;
    } catch (e) {
      debugPrint('Erro ao atualizar item da lista de compra: $e');
      rethrow;
    }
  }

  // Marcar ou desmarcar um item como comprado
  Future<ListaCompra> marcarItemComoComprado({
    required String listaId,
    required String itemId,
    required bool comprado,
  }) async {
    try {
      final userId = Supabase.instance.client.auth.currentUser!.id;
      final lista = await getListaCompra(listaId);
      if (lista == null) {
        throw Exception('Lista de compra não encontrada');
      }

      final novaLista = lista.copyWith(
        itens: lista.itens
            .map((i) => i.id == itemId ? i.copyWith(comprado: comprado) : i)
            .toList(),
      );

      await supabase
          .from(tableName)
          .update(novaLista.toMap())
          .eq('user_id', userId)
          .eq('id', lista.id);

      return novaLista;
    } catch (e) {
      debugPrint('Erro ao marcar item como comprado: $e');
      rethrow;
    }
  }

  // Remover um item da lista de compras
  Future<ListaCompra> removerItemListaCompra({
    required String listaId,
    required String itemId,
  }) async {
    try {
      final userId = Supabase.instance.client.auth.currentUser!.id;
      final lista = await getListaCompra(listaId);
      if (lista == null) {
        throw Exception('Lista de compra não encontrada');
      }

      final novaLista = lista.copyWith(
        itens: lista.itens.where((i) => i.id != itemId).toList(),
      );

      await supabase
          .from(tableName)
          .update(novaLista.toMap())
          .eq('user_id', userId)
          .eq('id', lista.id);

      await supabase
          .from('itens_lista_de_compras')
          .delete()
          .eq('lista_de_compras_id', listaId)
          .eq('id', itemId);

      return novaLista;
    } catch (e) {
      debugPrint('Erro ao remover item da lista de compra: $e');
      rethrow;
    }
  }

  Future<List<ItemListaCompra>> getItemsListaCompra(String listaId) async {
    try {
      final response = await supabase
          .from('itens_lista_de_compras')
          .select('*, produto:produto_id(*)')
          .eq('lista_de_compras_id', listaId);

      return response.map(ItemListaCompra.fromMap).toList();
    } catch (e) {
      debugPrint('Erro ao buscar itens da lista de compra: $e');
      return [];
    }
  }
}
