import 'package:equatable/equatable.dart';

class Loja extends Equatable {
  final String id;
  final String nome;
  final String? endereco;
  final String? imagemUrl;
  final double? avaliacao;

  const Loja({
    required this.id,
    required this.nome,
    this.endereco,
    this.imagemUrl,
    this.avaliacao,
  });

  factory Loja.fromMap(Map<String, dynamic> map) {
    return Loja(
      id: map['id'] as String,
      nome: map['nome'] as String,
      endereco: map['endereco'] as String?,
      imagemUrl: map['imagem_url'] as String?,
      avaliacao: map['avaliacao'] != null ? (map['avaliacao'] as num).toDouble() : null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': nome,
      'endereco': endereco,
      'imagem_url': imagemUrl,
      'avaliacao': avaliacao,
    };
  }

  @override
  List<Object?> get props => [id, nome, endereco, imagemUrl, avaliacao];
}
