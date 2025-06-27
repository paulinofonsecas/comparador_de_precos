part of 'admin_gestao_lojas_bloc.dart';

/// {@template admin_gestao_lojas_state}
/// AdminGestaoLojasState description
/// {@endtemplate}
class AdminGestaoLojasState extends Equatable {
  /// {@macro admin_gestao_lojas_state}
  const AdminGestaoLojasState({
    this.customProperty = 'Default Value',
  });

  /// A description for customProperty
  final String customProperty;

  @override
  List<Object> get props => [customProperty];

  /// Creates a copy of the current AdminGestaoLojasState with property changes
  AdminGestaoLojasState copyWith({
    String? customProperty,
  }) {
    return AdminGestaoLojasState(
      customProperty: customProperty ?? this.customProperty,
    );
  }
}

/// {@template admin_gestao_lojas_initial}
/// The initial state of AdminGestaoLojasState
/// {@endtemplate}
class AdminGestaoLojasInitial extends AdminGestaoLojasState {
  /// {@macro admin_gestao_lojas_initial}
  const AdminGestaoLojasInitial() : super();
}
