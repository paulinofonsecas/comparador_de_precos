// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Preco {
  final String uuid;
  final String produtoId;
  final String lojaId;
  final double preco;
  final bool disponivel;
  final bool? emPromocao;
  final double? precoPromocional;
  final String? profileIdAtualizador;
  final DateTime createdAt;
  final DateTime updatedAt;

  Preco({
    required this.uuid,
    required this.produtoId,
    required this.lojaId,
    required this.preco,
    required this.disponivel,
    required this.createdAt,
    required this.updatedAt,
    this.emPromocao,
    this.precoPromocional,
    this.profileIdAtualizador,
  });

  Preco copyWith({
    String? uuid,
    String? produtoId,
    double? preco,
    bool? disponivel,
    bool? emPromocao,
    double? precoPromocional,
    String? profileIdAtualizador,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Preco(
      uuid: uuid ?? this.uuid,
      produtoId: produtoId ?? this.produtoId,
      lojaId: lojaId,
      preco: preco ?? this.preco,
      disponivel: disponivel ?? this.disponivel,
      emPromocao: emPromocao ?? this.emPromocao,
      precoPromocional: precoPromocional ?? this.precoPromocional,
      profileIdAtualizador: profileIdAtualizador ?? this.profileIdAtualizador,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uuid': uuid,
      'produto_id': produtoId,
      'loja_id': lojaId,
      'preco': preco,
      'disponivel': disponivel,
      'em_promocao': emPromocao,
      'preco_promocional': precoPromocional,
      'profile_id_atualizador': profileIdAtualizador,
      'created_at': createdAt.millisecondsSinceEpoch,
      'updated_at': updatedAt.millisecondsSinceEpoch,
    };
  }

  factory Preco.fromMap(Map<String, dynamic> map) {
    return Preco(
      uuid: map['id'] as String,
      preco: (map['preco'] as num).toDouble(),
      lojaId: map['loja_id'] as String,
      emPromocao: map['em_promocao'] as bool? ?? false,
      disponivel: map['disponivel'] as bool? ?? false,
      produtoId: map['produto_id'] as String,
      precoPromocional: ((map['preco_promocional'] as num?) ?? 0.0).toDouble(),
      profileIdAtualizador: map['profile_id_atualizador'] as String?,
      createdAt: DateTime.parse(map['created_at'] as String),
      updatedAt: DateTime.parse(map['updated_at'] as String),
    );
  }

  String toJson() => json.encode(toMap());

  factory Preco.fromJson(String source) =>
      Preco.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Preco(uuid: $uuid, String: $String, preco: $preco, emPromocao: $emPromocao, precoPromocional: $precoPromocional, profileIdAtualizador: $profileIdAtualizador, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(covariant Preco other) {
    if (identical(this, other)) return true;

    return other.uuid == uuid &&
        other.produtoId == produtoId &&
        other.lojaId == lojaId &&
        other.preco == preco &&
        other.disponivel == disponivel &&
        other.emPromocao == emPromocao &&
        other.precoPromocional == precoPromocional &&
        other.profileIdAtualizador == profileIdAtualizador &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt;
  }

  @override
  int get hashCode {
    return uuid.hashCode ^
        produtoId.hashCode ^
        lojaId.hashCode ^
        preco.hashCode ^
        disponivel.hashCode ^
        emPromocao.hashCode ^
        precoPromocional.hashCode ^
        profileIdAtualizador.hashCode ^
        createdAt.hashCode ^
        updatedAt.hashCode;
  }
}
