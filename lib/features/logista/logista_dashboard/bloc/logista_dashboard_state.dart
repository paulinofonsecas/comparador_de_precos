part of 'logista_dashboard_bloc.dart';

/// {@template logista_dashboard_state}
/// LogistaDashboardState description
/// {@endtemplate}
class LogistaDashboardState extends Equatable {
  /// {@macro logista_dashboard_state}
  const LogistaDashboardState({
    this.customProperty = 'Default Value',
  });

  /// A description for customProperty
  final String customProperty;

  @override
  List<Object> get props => [customProperty];

  /// Creates a copy of the current LogistaDashboardState with property changes
  LogistaDashboardState copyWith({
    String? customProperty,
  }) {
    return LogistaDashboardState(
      customProperty: customProperty ?? this.customProperty,
    );
  }
}

/// {@template logista_dashboard_initial}
/// The initial state of LogistaDashboardState
/// {@endtemplate}
class LogistaDashboardInitial extends LogistaDashboardState {
  /// {@macro logista_dashboard_initial}
  const LogistaDashboardInitial() : super();
}
