// ignore_for_file: public_member_api_docs, sort_constructors_first, lines_longer_than_80_chars
import 'dart:convert';

class SolicitacaoLoja {
  final String id;
  final String nome;
  final String userProfileId;
  final String? status;
  final String? endereco;
  final String? telefoneContato;
  final double? latitude;
  final double? longitude;
  final String? descricao;
  final List<String> filePaths;
  final DateTime createdAt;
  final DateTime updatedAt;

  SolicitacaoLoja({
    required this.id,
    required this.nome,
    required this.userProfileId,
    this.status,
    this.endereco,
    this.telefoneContato,
    this.latitude,
    this.longitude,
    this.descricao,
    this.filePaths = const [],
    required this.createdAt,
    required this.updatedAt,
  });

  SolicitacaoLoja copyWith({
    String? id,
    String? userProfileId,
    String? nome,
    String? status,
    String? endereco,
    String? telefoneContato,
    double? latitude,
    double? longitude,
    String? descricao,
    List<String>? filePaths,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return SolicitacaoLoja(
      id: id ?? this.id,
      userProfileId: userProfileId ?? this.userProfileId,
      nome: nome ?? this.nome,
      status: status ?? this.status,
      endereco: endereco ?? this.endereco,
      telefoneContato: telefoneContato ?? this.telefoneContato,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      descricao: descricao ?? this.descricao,
      filePaths: filePaths ?? this.filePaths,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'user_profile_id': userProfileId,
      'nome': nome,
      'status': status,
      'endereco': endereco,
      'telefone_contato': telefoneContato,
      'latitude': latitude,
      'longitude': longitude,
      'descricao': descricao,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  factory SolicitacaoLoja.fromMap(Map<String, dynamic> map) {
    return SolicitacaoLoja(
      id: map['id'] as String,
      nome: map['nome'] as String,
      userProfileId: map['user_profile_id'] as String,
      status: map['status'] != null ? map['status'] as String : null,
      endereco: map['endereco'] != null ? map['endereco'] as String : null,
      telefoneContato: map['telefone_contato'] != null
          ? map['telefone_contato'] as String
          : null,
      latitude: map['latitude'] != null ? map['latitude'] as double : null,
      longitude: map['longitude'] != null ? map['longitude'] as double : null,
      descricao: map['descricao'] != null ? map['descricao'] as String : null,
      filePaths: map['file_paths'] != null
          ? List<String>.from(map['file_paths'] as List)
          : const [],
      createdAt: DateTime.parse(map['created_at'] as String),
      updatedAt: DateTime.parse(map['updated_at'] as String),
    );
  }

  String toJson() => json.encode(toMap());

  factory SolicitacaoLoja.fromJson(String source) =>
      SolicitacaoLoja.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool operator ==(covariant SolicitacaoLoja other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.nome == nome &&
        other.userProfileId == userProfileId &&
        other.status == status &&
        other.endereco == endereco &&
        other.telefoneContato == telefoneContato &&
        other.latitude == latitude &&
        other.longitude == longitude &&
        other.descricao == descricao &&
        other.filePaths == filePaths &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        nome.hashCode ^
        userProfileId.hashCode ^
        status.hashCode ^
        endereco.hashCode ^
        telefoneContato.hashCode ^
        latitude.hashCode ^
        longitude.hashCode ^
        descricao.hashCode ^
        filePaths.hashCode ^
        createdAt.hashCode ^
        updatedAt.hashCode;
  }
}
