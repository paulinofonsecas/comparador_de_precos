import 'package:comparador_de_precos/data/models/lista_compra.dart';
import 'package:comparador_de_precos/data/models/produto.dart';
import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uuid/uuid.dart';

class ListaCompraRepository {
  ListaCompraRepository();

  final supabase = Supabase.instance.client;
  final tableName = 'listas_de_compras';

  // Use a single instance of Uuid to avoid recreating it multiple times.
  // This is a minor optimization but good practice.
  final _uuid = const Uuid();

  // Obter todas as listas de compras do usuário
  Future<List<ListaCompra>> getListasCompra(String userId) async {
    // Added a stopwatch for basic performance measurement.
    // For more detailed analysis, consider using Flutter DevTools.
    final stopwatch = Stopwatch()..start();
    try {
      // Fetching lists and their items in a single query if possible,
      // or at least minimizing round trips, is usually more performant.
      // Supabase supports embedding related data.
      // The original code already does this for 'produto', which is good.
      // The main optimization here is to improve how items are associated with lists.
      final response = await supabase
          .from(tableName)
          .select(
              '*, itens_lista_de_compras(*, produto:produto_id(*))') // Fetch items directly with the list
          .eq('user_id', userId);

      // The 'response' now contains lists, and each list object has its items.
      // This eliminates the need for a separate query for items and complex mapping.
      final listas = response.map((listData) {
        // Assuming ListaCompra.fromMap can handle the nested 'itens_lista_de_compras'
        // If not, you'll need to adjust ListaCompra.fromMap or do the mapping here.
        // For example:
        // final itemsData = listData['itens_lista_de_compras'] as List<dynamic>? ?? [];
        // final items = itemsData.map(ItemListaCompra.fromMap).toList();
        // return ListaCompra.fromMap(listData).copyWith(itens: items);
        return ListaCompra.fromMap(listData);
      }).toList();

      debugPrint(
          'getListasCompra executed in ${stopwatch.elapsedMilliseconds}ms');
      return listas;
    } catch (e) {
      debugPrint('Erro ao buscar listas de compra: $e');
      rethrow;
    } finally {
      stopwatch.stop();
    }
  }

  // Obter uma lista de compras específica
  Future<ListaCompra?> getListaCompra(String listaId) async {
    final stopwatch = Stopwatch()..start();
    try {
      final userId = Supabase.instance.client.auth.currentUser!.id;
      // Fetch the list and its items in a single query.
      final response = await supabase
          .from(tableName)
          .select(
              '*, itens_lista_de_compras(*, produto:produto_id(*))') // Embed items and their products
          .eq('user_id', userId)
          .eq('id', listaId)
          .maybeSingle(); // Use maybeSingle to get one record or null, simplifying error handling.

      if (response == null) {
        return null;
      }

      // Assuming ListaCompra.fromMap can handle the nested items.
      // If not, map them similarly to getListasCompra.
      final listaCompra = ListaCompra.fromMap(response);

      debugPrint(
          'getListaCompra executed in ${stopwatch.elapsedMilliseconds}ms for id $listaId');
      return listaCompra;
    } catch (e) {
      debugPrint('Erro ao buscar lista de compra: $e');
      return null;
    } finally {
      stopwatch.stop();
    }
  }

  // Criar uma nova lista de compras
  Future<ListaCompra> criarListaCompra({
    required String nome,
    String? descricao,
  }) async {
    final stopwatch = Stopwatch()..start();
    try {
      final userId = Supabase.instance.client.auth.currentUser!.id;

      final novaLista = ListaCompra(
        id: _uuid.v4(),
        // Use the pre-initialized uuid instance
        nome: nome,
        userId: userId,
        dataCriacao: DateTime.now(),
        descricao: descricao,
        itens: [], // Itens will be empty initially
      );

      // Insert the new list and select it back to confirm and get any server-generated values (e.g., created_at if not set locally)
      // If you don't need to confirm or get server-generated values beyond what you set,
      // you can just return `novaLista` after the insert without the .select().
      final response = await supabase
          .from(tableName)
          .insert(novaLista.toMap())
          .select() // Select the inserted row
          .single(); // Expect a single row back

      debugPrint(
          'criarListaCompra executed in ${stopwatch.elapsedMilliseconds}ms');
      // Assuming ListaCompra.fromMap can handle the response correctly.
      return ListaCompra.fromMap(response);
    } catch (e) {
      debugPrint('Erro ao criar lista de compra: $e');
      rethrow;
    } finally {
      stopwatch.stop();
    }
  }

  // Atualizar uma lista de compras existente
  Future<ListaCompra> atualizarListaCompra(ListaCompra lista) async {
    final stopwatch = Stopwatch()..start();
    try {
      final userId = Supabase.instance.client.auth.currentUser!.id;
      // Only update the list itself, not its items directly in this call,
      // unless your toMap() method and backend are set up for deep updates.
      // Item updates are typically handled by separate methods.
      await supabase
          .from(tableName)
          .update(
            lista.toMap(),
          ) // Ensure toMap() only includes fields for the 'listas_de_compras' table
          .eq('user_id', userId)
          .eq('id', lista.id);

      // It's good practice to return the updated object as confirmed by the database,
      // or at least the input object if the update is assumed successful without changes from the DB.
      // For simplicity, returning the input `lista`. If you need server-updated fields (e.g. updated_at), fetch it.
      debugPrint(
          'atualizarListaCompra executed in ${stopwatch.elapsedMilliseconds}ms for id ${lista.id}');
      return lista;
    } catch (e) {
      debugPrint('Erro ao atualizar lista de compra: $e');
      rethrow;
    } finally {
      stopwatch.stop();
    }
  }

  // Excluir uma lista de compras
  Future<bool> excluirListaCompra(String listaId) async {
    final stopwatch = Stopwatch()..start();
    try {
      final userId = Supabase.instance.client.auth.currentUser!.id;

      // Supabase cascade deletes can be configured at the database level
      // to automatically delete related items when a list is deleted.
      // If cascade delete is set up for 'itens_lista_de_compras' when 'listas_de_compras' is deleted,
      // the first delete call becomes redundant.
      // Check your Supabase table schema for foreign key constraints and cascade options.

      // Assuming cascade delete is NOT set up, this is correct:
      await supabase
          .from('itens_lista_de_compras')
          .delete()
          .eq('lista_de_compras_id', listaId);

      await supabase
          .from(tableName)
          .delete()
          .eq('user_id', userId)
          .eq('id', listaId);

      debugPrint(
          'excluirListaCompra executed in ${stopwatch.elapsedMilliseconds}ms for id $listaId');
      return true;
    } catch (e) {
      debugPrint('Erro ao excluir lista de compra: $e');
      return false;
    } finally {
      stopwatch.stop();
    }
  }

  // Adicionar um item à lista de compras
  Future<ItemListaCompra> adicionarItemListaCompra({
    // Changed return type to ItemListaCompra for clarity
    required String listaId,
    required String produtoId,
    required int quantidade,
    String? observacao,
  }) async {
    final stopwatch = Stopwatch()..start();
    try {
      // final userId = Supabase.instance.client.auth.currentUser!.id; // userId not directly used in this insert

      final newItemMap = {
        'id': _uuid.v4(),
        // Generate ID for the item client-side
        'lista_de_compras_id': listaId,
        'produto_id': produtoId,
        'quantidade': quantidade,
        'observacao': observacao,
        // 'created_at' and 'updated_at' are often handled by the database by default.
        // If not, setting them client-side is fine, but ensure timezones are handled correctly.
        // 'created_at': DateTime.now().toIso8601String(),
        // 'updated_at': DateTime.now().toIso8601String(),
      };

      // Insert the new item and select it back to get the full object
      final response = await supabase
          .from('itens_lista_de_compras')
          .insert(newItemMap)
          .select(
              '*, produto:produto_id(*)') // Select the item with its product
          .single(); // Expect a single row

      final newItem = ItemListaCompra.fromMap(response);

      // Instead of re-fetching the entire list, just return the newly added item.
      // The calling UI/ViewModel can then update its local state more efficiently.
      // If the entire list object is strictly needed, the original getListaCompra(listaId) is okay,
      // but it's an extra DB call.

      debugPrint(
          'adicionarItemListaCompra executed in ${stopwatch.elapsedMilliseconds}ms for list id $listaId');
      return newItem;
    } catch (e) {
      debugPrint('Erro ao adicionar item à lista de compra: $e');
      rethrow;
    } finally {
      stopwatch.stop();
    }
  }

  // Atualizar um item da lista de compras
  Future<ItemListaCompra> atualizarItemListaCompra({
    required String listaId,
    required ItemListaCompra item,
  }) async {
    final stopwatch = Stopwatch()..start();
    try {
      // final userId = Supabase.instance.client.auth.currentUser!.id; // userId not used for item update directly via item ID

      // Ensure item.toMap() provides the correct data for the update.
      // It should include 'updated_at' if you're managing it client-side.
      final itemDataToUpdate = item.toMap();
      // 'updated_at': DateTime.now().toIso8601String(), // Example if handled client-side

      final response = await supabase
          .from('itens_lista_de_compras')
          .update(itemDataToUpdate)
          .eq('id', item.id)
          .eq('lista_de_compras_id', listaId)
          .select('*, produto:produto_id(*)')
          .single();

      // The original code was fetching the whole list, then updating it in the client,
      // then sending the whole list back to Supabase. This is inefficient.
      // It's better to update the specific item directly in the 'itens_lista_de_compras' table.

      debugPrint(
          'atualizarItemListaCompra executed in ${stopwatch.elapsedMilliseconds}ms for item id ${item.id}');
      return ItemListaCompra.fromMap(response);
    } catch (e) {
      debugPrint('Erro ao atualizar item da lista de compra: $e');
      rethrow;
    } finally {
      stopwatch.stop();
    }
  }

  // Marcar ou desmarcar um item como comprado
  Future<ItemListaCompra> marcarItemComoComprado({
    // Changed return type
    required String
        listaId, // Potentially not needed if itemId is globally unique
    required String itemId,
    required bool comprado,
  }) async {
    final stopwatch = Stopwatch()..start();
    try {
      // final userId = Supabase.instance.client.auth.currentUser!.id; // Not directly used for this specific item update

      // Update only the 'comprado' status of the specific item.
      final response = await supabase
          .from('itens_lista_de_compras')
          .update({
            'comprado': comprado,
          })
          .eq('id', itemId)
          // .eq('lista_de_compras_id', listaId) // Optional: for added security/scoping
          .select('*, produto:produto_id(*)') // Select the updated item
          .single();

      // Similar to atualizarItemListaCompra, updating the specific item is more efficient
      // than fetching the whole list, modifying it, and saving the whole list.

      debugPrint(
          'marcarItemComoComprado executed in ${stopwatch.elapsedMilliseconds}ms for item id $itemId');
      return ItemListaCompra.fromMap(response);
    } catch (e) {
      debugPrint('Erro ao marcar item como comprado: $e');
      rethrow;
    } finally {
      stopwatch.stop();
    }
  }

  // Remover um item da lista de compras
  Future<void> removerItemListaCompra({
    // Changed return type to Future<void> as we are just deleting
    required String listaId, // Required to scope the deletion
    required String itemId,
  }) async {
    final stopwatch = Stopwatch()..start();
    try {
      // final userId = Supabase.instance.client.auth.currentUser!.id; // Not directly used

      // The original code fetched the list, modified it locally, updated the entire list (inefficient),
      // and then deleted the item. It's much more direct to just delete the item.
      await supabase
          .from('itens_lista_de_compras')
          .delete()
          .eq('lista_de_compras_id',
              listaId) // Ensure we delete from the correct list
          .eq('id', itemId);

      // The UI/ViewModel should handle removing the item from its local state.
      // Returning the modified list is often an unnecessary overhead.

      debugPrint(
          'removerItemListaCompra executed in ${stopwatch.elapsedMilliseconds}ms for item id $itemId from list $listaId');
    } catch (e) {
      debugPrint('Erro ao remover item da lista de compra: $e');
      rethrow;
    } finally {
      stopwatch.stop();
    }
  }

  // This method is good as is, serving a specific purpose.
  Future<List<ItemListaCompra>> getItemsListaCompra(String listaId) async {
    final stopwatch = Stopwatch()..start();
    try {
      final response = await supabase
          .from('itens_lista_de_compras')
          .select('*, produto:produto_id(*)')
          .eq('lista_de_compras_id', listaId);

      final items = response.map(ItemListaCompra.fromMap).toList();
      debugPrint(
          'getItemsListaCompra executed in ${stopwatch.elapsedMilliseconds}ms for list id $listaId');
      return items;
    } catch (e) {
      debugPrint('Erro ao buscar itens da lista de compra: $e');
      return [];
    } finally {
      stopwatch.stop();
    }
  }
}

// Ensure your ListaCompra.fromMap and ItemListaCompra.fromMap can handle
// the nested data structures that result from Supabase's select queries
// with foreign table embedding (e.g., 'itens_lista_de_compras(*, produto:produto_id(*))').

/*
Example of how ListaCompra.fromMap might need to be structured:

class ListaCompra {
  // ... other fields
  final List<ItemListaCompra> itens;

  ListaCompra({
    required this.id,
    required this.nome,
    required this.userId,
    required this.dataCriacao,
    this.descricao,
    required this.itens,
  });

  factory ListaCompra.fromMap(Map<String, dynamic> map) {
    // Handle the nested items if they are part of the map
    var itemsList = <ItemListaCompra>[];
    if (map['itens_lista_de_compras'] != null && map['itens_lista_de_compras'] is List) {
      itemsList = (map['itens_lista_de_compras'] as List)
          .map((itemData) => ItemListaCompra.fromMap(itemData as Map<String, dynamic>))
          .toList();
    }

    return ListaCompra(
      id: map['id'] as String,
      nome: map['nome'] as String,
      userId: map['user_id'] as String,
      dataCriacao: DateTime.parse(map['data_criacao'] as String),
      descricao: map['descricao'] as String?,
      itens: itemsList, // Assign the parsed items
    );
  }

  Map<String, dynamic> toMap() {
    // When sending to Supabase for updating the list itself,
    // you typically don't include the 'itens' directly in the map for the 'listas_de_compras' table.
    // Item manipulations should be done on the 'itens_lista_de_compras' table.
    return {
      'id': id,
      'nome': nome,
      'user_id': userId,
      'data_criacao': dataCriacao.toIso8601String(),
      'descricao': descricao,
      // 'itens': itens.map((item) => item.toMap()).toList(), // Usually not included here
    };
  }

  ListaCompra copyWith({
    String? id,
    String? nome,
    String? userId,
    DateTime? dataCriacao,
    String? descricao,
    List<ItemListaCompra>? itens,
  }) {
    return ListaCompra(
      id: id ?? this.id,
      nome: nome ?? this.nome,
      userId: userId ?? this.userId,
      dataCriacao: dataCriacao ?? this.dataCriacao,
      descricao: descricao ?? this.descricao,
      itens: itens ?? this.itens,
    );
  }
}
*/
