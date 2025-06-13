import 'package:comparador_de_precos/data/models/loja.dart';

class LojaComDistancia extends Loja {

  LojaComDistancia({
    required super.id,
    super.profileIdLojista,
    required super.nome,
    super.endereco,
    super.latitude,
    super.longitude,
    super.telefoneContato,
    super.descricao,
    super.logoUrl,
    super.aprovada,
    required super.createdAt,
    required super.updatedAt,
    required this.distanciaKm,
  });

  factory LojaComDistancia.fromJson(Map<String, dynamic> json) {
    return LojaComDistancia(
      id: json['id'] as String,
      profileIdLojista: json['profile_id_lojista'] as String?,
      nome: json['nome'] as String,
      endereco: json['endereco'] as String?,
      latitude: json['latitude'] as double?,
      longitude: json['longitude'] as double?,
      telefoneContato: json['telefone_contato'] as String?,
      descricao: json['descricao'] as String?,
      logoUrl: json['logo_url'] as String?,
      aprovada: json['aprovada'] as bool?,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
      distanciaKm: json['distancia_km'] as double? ?? 0.0,
    );
  }

  /// Create a LojaComDistancia from a Loja object
  factory LojaComDistancia.fromLoja(Loja loja, double distanciaKm) {
    return LojaComDistancia(
      id: loja.id,
      profileIdLojista: loja.profileIdLojista,
      nome: loja.nome,
      endereco: loja.endereco,
      latitude: loja.latitude,
      longitude: loja.longitude,
      telefoneContato: loja.telefoneContato,
      descricao: loja.descricao,
      logoUrl: loja.logoUrl,
      aprovada: loja.aprovada,
      createdAt: loja.createdAt,
      updatedAt: loja.updatedAt,
      distanciaKm: distanciaKm,
    );
  }
  final double distanciaKm;

  @override
  Map<String, dynamic> toJson() {
    final json = super.toJson();
    json['distancia_km'] = distanciaKm;
    return json;
  }
}
