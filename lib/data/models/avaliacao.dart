class Avaliacao {
  final String id;
  final String lojaId;
  final String? usuarioId;
  final String? usuarioNome;
  final double classificacao; // Classificação de 1 a 5 estrelas
  final String? comentario;
  final DateTime createdAt;
  final DateTime updatedAt;

  Avaliacao({
    required this.id,
    required this.lojaId,
    this.usuarioId,
    this.usuarioNome,
    required this.classificacao,
    this.comentario,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Avaliacao.fromJson(Map<String, dynamic> json) {
    return Avaliacao(
      id: json['id'] as String,
      lojaId: json['loja_id'] as String,
      usuarioId: json['usuario_id'] as String?,
      usuarioNome: json['usuario_nome'] as String?,
      classificacao: (json['classificacao'] as num).toDouble(),
      comentario: json['comentario'] as String?,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'loja_id': lojaId,
      'usuario_id': usuarioId,
      'usuario_nome': usuarioNome,
      'classificacao': classificacao,
      'comentario': comentario,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}
