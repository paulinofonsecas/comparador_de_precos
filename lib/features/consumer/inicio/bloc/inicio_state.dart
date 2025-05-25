part of 'inicio_bloc.dart';

/// {@template inicio_state}
/// InicioState description
/// {@endtemplate}
class InicioState extends Equatable {
  /// {@macro inicio_state}
  const InicioState({
    this.customProperty = 'Default Value',
  });

  /// A description for customProperty
  final String customProperty;

  @override
  List<Object> get props => [customProperty];

  /// Creates a copy of the current InicioState with property changes
  InicioState copyWith({
    String? customProperty,
  }) {
    return InicioState(
      customProperty: customProperty ?? this.customProperty,
    );
  }
}

/// {@template inicio_initial}
/// The initial state of InicioState
/// {@endtemplate}
class InicioInitial extends InicioState {
  /// {@macro inicio_initial}
  const InicioInitial() : super();
}
