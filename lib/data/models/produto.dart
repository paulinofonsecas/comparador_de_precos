import 'dart:convert';

import 'package:comparador_de_precos/data/models/categoria.dart';

class Produto {
  final String id;
  final String nome;
  final String? marca;
  final String? descricao;
  final String? imagemUrl;
  final String? categoriaId;
  final Categoria? categoria;

  Produto({
    required this.id,
    required this.nome,
    this.marca,
    this.descricao,
    this.imagemUrl,
    this.categoriaId,
    this.categoria,
  });

  Produto copyWith({
    String? id,
    String? nome,
    String? marca,
    String? descricao,
    String? imagemUrl,
    String? categoriaId,
    Categoria? categoria,
  }) {
    return Produto(
      id: id ?? this.id,
      nome: nome ?? this.nome,
      marca: marca ?? this.marca,
      descricao: descricao ?? this.descricao,
      imagemUrl: imagemUrl ?? this.imagemUrl,
      categoriaId: categoriaId ?? this.categoriaId,
      categoria: categoria ?? this.categoria,
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
    };
  }

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
    );
  }

  String toJson() => json.encode(toMap());

  factory Produto.fromJson(String source) =>
      Produto.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Produto(id: $id, nome: $nome, marca: $marca, descricao: $descricao, imagemUrl: $imagemUrl, categoriaId: $categoriaId, categoria: $categoria)';
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
        other.categoria == categoria;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        nome.hashCode ^
        marca.hashCode ^
        descricao.hashCode ^
        imagemUrl.hashCode ^
        categoriaId.hashCode ^
        categoria.hashCode;
  }
}
