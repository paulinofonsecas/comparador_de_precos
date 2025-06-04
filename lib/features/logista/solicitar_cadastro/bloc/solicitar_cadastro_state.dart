part of 'solicitar_cadastro_bloc.dart';

/// {@template solicitar_cadastro_state}
/// SolicitarCadastroState description
/// {@endtemplate}
class SolicitarCadastroState extends Equatable {
  /// {@macro solicitar_cadastro_state}
  const SolicitarCadastroState({
    this.customProperty = 'Default Value',
  });

  /// A description for customProperty
  final String customProperty;

  @override
  List<Object> get props => [customProperty];

  /// Creates a copy of the current SolicitarCadastroState with property changes
  SolicitarCadastroState copyWith({
    String? customProperty,
  }) {
    return SolicitarCadastroState(
      customProperty: customProperty ?? this.customProperty,
    );
  }
}

/// {@template solicitar_cadastro_initial}
/// The initial state of SolicitarCadastroState
/// {@endtemplate}
class SolicitarCadastroInitial extends SolicitarCadastroState {
  /// {@macro solicitar_cadastro_initial}
  const SolicitarCadastroInitial() : super();
}
