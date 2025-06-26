// Para @required se você estiver em versões mais antigas, ou use 'late'

// Enum para representar os tipos de usuário de forma mais segura
enum UserType {
  consumidor('consumidor'),
  lojista('lojista'),
  admin('admin');

  const UserType(this.name);

  final String name;
}

// Função para converter String para UserType
UserType userTypeFromString(String? typeString) {
  if (typeString == 'lojista') {
    return UserType.lojista;
  }

  if (typeString == 'admin') {
    return UserType.admin;
  }

  // Adicione mais conversões se tiver mais tipos
  return UserType.consumidor; // Padrão para consumidor
}

// Função para converter UserType para String (para salvar no DB)
String userTypeToString(UserType type) {
  return type.name; // .name pega o nome do enum como string (ex: "consumidor")
}

class UserProfile {
  UserProfile({
    required this.id,
    required this.userId,
    this.bi,
    this.nomeCompleto,
    required this.tipoUsuario,
    this.telefone,
    required this.createdAt,
    this.updatedAt,
  });

  // Construtor factory para criar uma instância a partir de um Map (JSON vindo do Supabase)
  factory UserProfile.fromMap(Map<String, dynamic> map) {
    // Validação básica para campos obrigatórios
    if (map['id'] == null ||
        map['user_id'] == null ||
        map['tipo_usuario'] == null ||
        map['created_at'] == null) {
      throw ArgumentError(
          'Campos obrigatórios (id, user_id, tipo_usuario, created_at) não podem ser nulos ao criar UserProfile a partir do Map.');
    }

    return UserProfile(
      id: map['id'] as String,
      userId: map['user_id'] as String,
      bi: map['bi'] as String?,
      nomeCompleto: map['nome_completo'] as String?,
      tipoUsuario: userTypeFromString(map['tipo_usuario'] as String?),
      telefone: map['telefone'] as String?,
      createdAt: DateTime.parse(map['created_at'] as String),
      updatedAt: map['updated_at'] != null
          ? DateTime.parse(map['updated_at'] as String)
          : null,
    );
  }
  final String id; // UUID do perfil (PK da tabela profiles)
  final String userId; // UUID do auth.users (FK)
  final String? bi;
  String? nomeCompleto;
  UserType tipoUsuario;
  String? telefone;
  final DateTime createdAt;
  DateTime? updatedAt;

  // Método para converter a instância para um Map (JSON para enviar ao Supabase)
  Map<String, dynamic> toMap() {
    return {
      'id':
          id, // Geralmente não enviado em updates se for auto-gerado, mas útil para inserts se o ID já existir
      'user_id': userId,
      'bi': bi,
      'nome_completo': nomeCompleto,
      'tipo_usuario': userTypeToString(tipoUsuario),
      'telefone': telefone,
      // createdAt é gerenciado pelo DB
      'updated_at': updatedAt?.toIso8601String() ??
          DateTime.now().toIso8601String(), // Envia a data atual se nulo
    };
  }

  // Método para criar uma cópia do objeto com alguns campos modificados (imutabilidade)
  UserProfile copyWith({
    String? id,
    String? userId,
    String? nomeCompleto,
    UserType? tipoUsuario,
    String? bi,
    String? telefone,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return UserProfile(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      bi: bi ?? this.bi,
      nomeCompleto: nomeCompleto ?? this.nomeCompleto,
      tipoUsuario: tipoUsuario ?? this.tipoUsuario,
      telefone: telefone ?? this.telefone,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  String toString() {
    return 'UserProfile(id: $id, userId: $userId, nomeCompleto: $nomeCompleto, tipoUsuario: $tipoUsuario, telefone: $telefone, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  // Implementação de igualdadade e hashCode para facilitar comparações e uso em coleções
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserProfile &&
        other.id == id &&
        other.userId == userId &&
        other.nomeCompleto == nomeCompleto &&
        other.tipoUsuario == tipoUsuario &&
        other.telefone == telefone &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        userId.hashCode ^
        nomeCompleto.hashCode ^
        tipoUsuario.hashCode ^
        telefone.hashCode ^
        createdAt.hashCode ^
        updatedAt.hashCode;
  }
}
