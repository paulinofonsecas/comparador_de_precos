import 'dart:convert';

import 'package:comparador_de_precos/data/models/categoria.dart';

class Produto {
  Produto({
    required this.id,
    required this.nome,
    this.marca,
    this.descricao,
    this.imagemUrl,
    this.categoriaId,
    this.categoria,
    this.precoMinimo,
  });

  factory Produto.fromMap(Map<String, dynamic> map) {
    return Produto(
      id: map['id'] as String,
      nome: map['nome'] as String,
      marca: map['marca'] as String?,
      descricao: map['descricao'] as String?,
      imagemUrl: map['imagem_url'] as String?,
      categoriaId: map['categoria_id'] as String?,
      categoria: map['categoria'] != null
          ? Categoria.fromMap(map['categoria'] as Map<String, dynamic>)
          : null,
      precoMinimo: map['preco_minimo'] as double?,
    );
  }

  factory Produto.fromJson(String source) =>
      Produto.fromMap(json.decode(source) as Map<String, dynamic>);

  final String id;
  final String nome;
  final String? marca;
  final String? descricao;
  final String? imagemUrl;
  final String? categoriaId;
  final Categoria? categoria;
  final double? precoMinimo;

  Produto copyWith({
    String? id,
    String? nome,
    String? marca,
    String? descricao,
    String? imagemUrl,
    String? categoriaId,
    Categoria? categoria,
    double? precoMinimo,
  }) {
    return Produto(
      id: id ?? this.id,
      nome: nome ?? this.nome,
      marca: marca ?? this.marca,
      descricao: descricao ?? this.descricao,
      imagemUrl: imagemUrl ?? this.imagemUrl,
      categoriaId: categoriaId ?? this.categoriaId,
      categoria: categoria ?? this.categoria,
      precoMinimo: precoMinimo ?? this.precoMinimo,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': nome,
      'marca': marca,
      'descricao': descricao,
      'imagem_url': imagemUrl,
      'categoria_id': categoriaId,
      'categoria': categoria?.toMap(),
      'preco_minimo': precoMinimo,
    };
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() {
    return 'Produto(id: $id, nome: $nome, marca: $marca, descricao: $descricao, imagemUrl: $imagemUrl, categoriaId: $categoriaId, categoria: $categoria, precoMinimo: $precoMinimo)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Produto &&
        other.id == id &&
        other.nome == nome &&
        other.marca == marca &&
        other.descricao == descricao &&
        other.imagemUrl == imagemUrl &&
        other.categoriaId == categoriaId &&
        other.categoria == categoria &&
        other.precoMinimo == precoMinimo;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        nome.hashCode ^
        marca.hashCode ^
        descricao.hashCode ^
        imagemUrl.hashCode ^
        categoriaId.hashCode ^
        categoria.hashCode ^
        precoMinimo.hashCode;
  }
}
