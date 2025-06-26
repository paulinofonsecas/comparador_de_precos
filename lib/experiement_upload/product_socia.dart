// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class SociaProduct {
  final int id;
  final String? foto;
  final int quantidade;
  final double preco;
  final int? desconto;
  final String produto;
  final String? descricao;
  final bool? estado;
  final int? stoqueExistente;

  SociaProduct({
    required this.id,
    required this.quantidade,
    required this.preco,
    required this.produto,
    this.foto,
    this.desconto,
    this.descricao,
    this.estado,
    this.stoqueExistente,
  });

  SociaProduct copyWith({
    int? id,
    String? foto,
    int? quantidade,
    double? preco,
    int? desconto,
    String? produto,
    String? descricao,
    bool? estado,
    int? stoqueExistente,
  }) {
    return SociaProduct(
      id: id ?? this.id,
      foto: foto ?? this.foto,
      quantidade: quantidade ?? this.quantidade,
      preco: preco ?? this.preco,
      desconto: desconto ?? this.desconto,
      produto: produto ?? this.produto,
      descricao: descricao ?? this.descricao,
      estado: estado ?? this.estado,
      stoqueExistente: stoqueExistente ?? this.stoqueExistente,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'foto': foto,
      'quantidade': quantidade,
      'preco': preco,
      'desconto': desconto,
      'produto': produto,
      'descricao': descricao,
      'estado': estado,
      'stoqueExistente': stoqueExistente,
    };
  }

  factory SociaProduct.fromMap(Map<String, dynamic> map) {
    return SociaProduct(
      id: int.parse(map['id'] as String),
      foto: map['featured_image'] != null ? map['featured_image']['source'] as String : null,
      quantidade: 0,
      preco: double.parse(map['price']['value'] as String),
      desconto: map['desconto'] != null ? map['desconto'] as int : null,
      produto: map['title'] as String,
      descricao: map['description'] != null ? map['description'] as String : null,
      estado: map['estado'] != null ? map['estado'] as bool : null,
      stoqueExistente: map['stoqueExistente'] != null
          ? (map['stoqueExistente'] as num).toInt()
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory SociaProduct.fromJson(String source) =>
      SociaProduct.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'SociaProduct(id: $id, foto: $foto, quantidade: $quantidade, preco: $preco, desconto: $desconto, produto: $produto, descricao: $descricao, estado: $estado, stoqueExistente: $stoqueExistente)';
  }

  @override
  bool operator ==(covariant SociaProduct other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.foto == foto &&
        other.quantidade == quantidade &&
        other.preco == preco &&
        other.desconto == desconto &&
        other.produto == produto &&
        other.descricao == descricao &&
        other.estado == estado &&
        other.stoqueExistente == stoqueExistente;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        foto.hashCode ^
        quantidade.hashCode ^
        preco.hashCode ^
        desconto.hashCode ^
        produto.hashCode ^
        descricao.hashCode ^
        estado.hashCode ^
        stoqueExistente.hashCode;
  }
}
