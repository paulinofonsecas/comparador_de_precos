import 'dart:convert';

class Categoria {

  Categoria({
    required this.id,
    required this.nome,
  });

  factory Categoria.fromMap(Map<String, dynamic> map) {
    return Categoria(
      id: map['id'] as String,
      nome: map['nome'] as String,
    );
  }

  factory Categoria.fromJson(String source) =>
      Categoria.fromMap(json.decode(source) as Map<String, dynamic>);
  final String id;
  final String nome;

  Categoria copyWith({
    String? id,
    String? nome,
  }) {
    return Categoria(
      id: id ?? this.id,
      nome: nome ?? this.nome,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': nome,
    };
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() => 'Categoria(id: $id, nome: $nome)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Categoria && other.id == id && other.nome == nome;
  }

  @override
  int get hashCode => id.hashCode ^ nome.hashCode;
}
