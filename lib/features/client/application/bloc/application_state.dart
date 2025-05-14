part of 'application_bloc.dart';

/// {@template application_state}
/// ApplicationState description
/// {@endtemplate}
class ApplicationState extends Equatable {
  /// {@macro application_state}
  const ApplicationState({
    this.customProperty = 'Default Value',
  });

  /// A description for customProperty
  final String customProperty;

  @override
  List<Object> get props => [customProperty];

  /// Creates a copy of the current ApplicationState with property changes
  ApplicationState copyWith({
    String? customProperty,
  }) {
    return ApplicationState(
      customProperty: customProperty ?? this.customProperty,
    );
  }
}

/// {@template application_initial}
/// The initial state of ApplicationState
/// {@endtemplate}
class ApplicationInitial extends ApplicationState {
  /// {@macro application_initial}
  const ApplicationInitial() : super();
}
