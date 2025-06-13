// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:comparador_de_precos/data/models/produto.dart';
import 'package:comparador_de_precos/data/repositories/preco.dart';
import 'package:postgrest/src/types.dart';

class ProductWithPrice {
  ProductWithPrice({
    required this.produto,
    required this.preco,
  });

  final Produto produto;
  final Preco preco;

  ProductWithPrice copyWith({
    Produto? produto,
    Preco? preco,
  }) {
    return ProductWithPrice(
      produto: produto ?? this.produto,
      preco: preco ?? this.preco,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'produto': produto.toMap(),
      'preco': preco.toMap(),
    };
  }

  factory ProductWithPrice.fromMap(Map<String, dynamic> map) {
    return ProductWithPrice(
      produto: Produto.fromMap(map['produtos'] as Map<String, dynamic>),
      preco: Preco.fromMap(map),
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductWithPrice.fromJson(String source) =>
      ProductWithPrice.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'ProdutoWithPrice(produto: $produto, preco: $preco)';

  @override
  bool operator ==(covariant ProductWithPrice other) {
    if (identical(this, other)) return true;

    return other.produto == produto && other.preco == preco;
  }

  @override
  int get hashCode => produto.hashCode ^ preco.hashCode;

  static Future<List<ProductWithPrice>> fromList(PostgrestList response) {
    return Future.value(
      response.map((item) {
        return ProductWithPrice.fromMap(item);
      }).toList(),
    );
  }
}
