part of 'logista_produtos_associados_bloc.dart';

/// {@template logista_produtos_associados_state}
/// LogistaProdutosAssociadosState description
/// {@endtemplate}
class LogistaProdutosAssociadosState extends Equatable {
  /// {@macro logista_produtos_associados_state}
  const LogistaProdutosAssociadosState({
    this.customProperty = 'Default Value',
  });

  /// A description for customProperty
  final String customProperty;

  @override
  List<Object> get props => [customProperty];

  /// Creates a copy of the current LogistaProdutosAssociadosState with property changes
  LogistaProdutosAssociadosState copyWith({
    String? customProperty,
  }) {
    return LogistaProdutosAssociadosState(
      customProperty: customProperty ?? this.customProperty,
    );
  }
}

/// {@template logista_produtos_associados_initial}
/// The initial state of LogistaProdutosAssociadosState
/// {@endtemplate}
class LogistaProdutosAssociadosInitial extends LogistaProdutosAssociadosState {
  /// {@macro logista_produtos_associados_initial}
  const LogistaProdutosAssociadosInitial() : super();
}
