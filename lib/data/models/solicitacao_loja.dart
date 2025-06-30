// ignore_for_file: public_member_api_docs, sort_constructors_first, lines_longer_than_80_chars
import 'dart:convert';

class SolicitacaoLoja {
  final String id;
  final String nome;
  final String? endereco;
  final String? telefoneContato;
  final double? latitude;
  final double? longitude;
  final String? descricao;
  final String nomeCompletoUsuario;
  final String emailUsuario;
  final DateTime createdAt;
  final DateTime updatedAt;

  SolicitacaoLoja({
    required this.id,
    required this.nome,
    this.endereco,
    this.telefoneContato,
    this.latitude,
    this.longitude,
    this.descricao,
    required this.nomeCompletoUsuario,
    required this.emailUsuario,
    required this.createdAt,
    required this.updatedAt,
  });

  SolicitacaoLoja copyWith({
    String? id,
    String? nome,
    String? endereco,
    String? telefoneContato,
    double? latitude,
    double? longitude,
    String? descricao,
    String? nomeCompletoUsuario,
    String? emailUsuario,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return SolicitacaoLoja(
      id: id ?? this.id,
      nome: nome ?? this.nome,
      endereco: endereco ?? this.endereco,
      telefoneContato: telefoneContato ?? this.telefoneContato,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      descricao: descricao ?? this.descricao,
      nomeCompletoUsuario: nomeCompletoUsuario ?? this.nomeCompletoUsuario,
      emailUsuario: emailUsuario ?? this.emailUsuario,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'nome': nome,
      'endereco': endereco,
      'telefone_contato': telefoneContato,
      'latitude': latitude,
      'longitude': longitude,
      'descricao': descricao,
      'nome_completo_usuario': nomeCompletoUsuario,
      'email_usuario': emailUsuario,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  factory SolicitacaoLoja.fromMap(Map<String, dynamic> map) {
    return SolicitacaoLoja(
      id: map['id'] as String,
      nome: map['nome'] as String,
      endereco: map['endereco'] != null ? map['endereco'] as String : null,
      telefoneContato: map['telefone_contato'] != null
          ? map['telefone_contato'] as String
          : null,
      latitude: map['latitude'] != null ? map['latitude'] as double : null,
      longitude: map['longitude'] != null ? map['longitude'] as double : null,
      descricao: map['descricao'] != null ? map['descricao'] as String : null,
      nomeCompletoUsuario: map['nome_completo_usuario'] as String,
      emailUsuario: map['email_usuario'] as String,
      createdAt: DateTime.parse(map['created_at'] as String),
      updatedAt: DateTime.parse(map['updated_at'] as String),
    );
  }

  String toJson() => json.encode(toMap());

  factory SolicitacaoLoja.fromJson(String source) =>
      SolicitacaoLoja.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Loja(id: $id, nome: $nome, endereco: $endereco, telefoneContato: $telefoneContato, latitude: $latitude, longitude: $longitude, descricao: $descricao, nomeCompletoUsuario: $nomeCompletoUsuario, emailUsuario: $emailUsuario, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(covariant SolicitacaoLoja other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.nome == nome &&
        other.endereco == endereco &&
        other.telefoneContato == telefoneContato &&
        other.latitude == latitude &&
        other.longitude == longitude &&
        other.descricao == descricao &&
        other.nomeCompletoUsuario == nomeCompletoUsuario &&
        other.emailUsuario == emailUsuario &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        nome.hashCode ^
        endereco.hashCode ^
        telefoneContato.hashCode ^
        latitude.hashCode ^
        longitude.hashCode ^
        descricao.hashCode ^
        nomeCompletoUsuario.hashCode ^
        emailUsuario.hashCode ^
        createdAt.hashCode ^
        updatedAt.hashCode;
  }
}
