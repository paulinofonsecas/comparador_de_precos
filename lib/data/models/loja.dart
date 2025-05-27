class Loja {
  final String id;
  final String? profileIdLojista;
  final String nome;
  final String? endereco;
  final double? latitude;
  final double? longitude;
  final String? telefoneContato;
  final String? descricao;
  final String? logoUrl;
  final bool? aprovada;
  final DateTime createdAt;
  final DateTime updatedAt;

  Loja({
    required this.id,
    this.profileIdLojista,
    required this.nome,
    this.endereco,
    this.latitude,
    this.longitude,
    this.telefoneContato,
    this.descricao,
    this.logoUrl,
    this.aprovada,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Loja.fromJson(Map<String, dynamic> json) {
    return Loja(
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
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'profile_id_lojista': profileIdLojista,
      'nome': nome,
      'endereco': endereco,
      'latitude': latitude,
      'longitude': longitude,
      'telefone_contato': telefoneContato,
      'descricao': descricao,
      'logo_url': logoUrl,
      'aprovada': aprovada,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}
