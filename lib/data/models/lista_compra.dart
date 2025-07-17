import 'dart:convert';

import 'package:comparador_de_precos/data/models/produto.dart';

class ItemListaCompra {
  ItemListaCompra({
    required this.id,
    required this.produtoId,
    required this.quantidade,
    this.produto,
    this.observacao,
    this.comprado = false,
  });

  factory ItemListaCompra.fromMap(Map<String, dynamic> map) {
    return ItemListaCompra(
      id: map['id'] as String,
      produtoId: map['produto_id'] as String,
      quantidade: map['quantidade'] as int,
      produto: map['produto'] != null
          ? Produto.fromMap(map['produto'] as Map<String, dynamic>)
          : null,
      observacao: map['observacao'] as String?,
      comprado: map['comprado'] as bool? ?? false,
    );
  }

  factory ItemListaCompra.fromJson(String source) =>
      ItemListaCompra.fromMap(json.decode(source) as Map<String, dynamic>);

  final String id;
  final String produtoId;
  // final String lojaId;
  final int quantidade;
  final Produto? produto;
  final String? observacao;
  final bool comprado;

  ItemListaCompra copyWith({
    String? id,
    String? produtoId,
    int? quantidade,
    Produto? produto,
    String? observacao,
    bool? comprado,
  }) {
    return ItemListaCompra(
      id: id ?? this.id,
      produtoId: produtoId ?? this.produtoId,
      quantidade: quantidade ?? this.quantidade,
      produto: produto ?? this.produto,
      observacao: observacao ?? this.observacao,
      comprado: comprado ?? this.comprado,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'produto_id': produtoId,
      'quantidade': quantidade,
      // 'produto': produto?.toMap(),
      'observacao': observacao,
      'comprado': comprado,
    };
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() {
    return 'ItemListaCompra(id: $id, produtoId: $produtoId, quantidade: $quantidade, produto: $produto, observacao: $observacao, comprado: $comprado)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ItemListaCompra &&
        other.id == id &&
        other.produtoId == produtoId &&
        other.quantidade == quantidade &&
        other.produto == produto &&
        other.observacao == observacao &&
        other.comprado == comprado;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        produtoId.hashCode ^
        quantidade.hashCode ^
        produto.hashCode ^
        observacao.hashCode ^
        comprado.hashCode;
  }
}

class ListaCompra {
  ListaCompra({
    required this.id,
    required this.nome,
    required this.userId,
    required this.dataCriacao,
    this.itens = const [],
    this.descricao,
  });

  factory ListaCompra.fromMap(Map<String, dynamic> map) {
    return ListaCompra(
      id: map['id'] as String,
      nome: map['nome'] as String,
      userId: map['user_id'] as String,
      dataCriacao: DateTime.parse(map['created_at'] as String),
      itens: map['itens_lista_de_compras'] != null
          ? List<ItemListaCompra>.from(
              (map['itens_lista_de_compras'] as List).map<ItemListaCompra>(
                (x) => ItemListaCompra.fromMap(x as Map<String, dynamic>),
              ),
            )
          : [],
      descricao: map['descricao'] as String?,
    );
  }

  factory ListaCompra.fromJson(String source) =>
      ListaCompra.fromMap(json.decode(source) as Map<String, dynamic>);

  final String id;
  final String nome;
  final String userId;
  final DateTime dataCriacao;
  final List<ItemListaCompra> itens;
  final String? descricao;

  ListaCompra copyWith({
    String? id,
    String? nome,
    String? userId,
    DateTime? dataCriacao,
    List<ItemListaCompra>? itens,
    String? descricao,
  }) {
    return ListaCompra(
      id: id ?? this.id,
      nome: nome ?? this.nome,
      userId: userId ?? this.userId,
      dataCriacao: dataCriacao ?? this.dataCriacao,
      itens: itens ?? this.itens,
      descricao: descricao ?? this.descricao,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': nome,
      'user_id': userId,
      'descricao': descricao,
      'created_at': dataCriacao.toIso8601String(),
    };
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() {
    return 'ListaCompra(id: $id, nome: $nome, userId: $userId, dataCriacao: '
        '$dataCriacao, itens: $itens, descricao: $descricao)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ListaCompra &&
        other.id == id &&
        other.nome == nome &&
        other.userId == userId &&
        other.dataCriacao == dataCriacao &&
        other.itens == itens &&
        other.descricao == descricao;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        nome.hashCode ^
        userId.hashCode ^
        dataCriacao.hashCode ^
        itens.hashCode ^
        descricao.hashCode;
  }
}
