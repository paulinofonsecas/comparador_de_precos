part of 'admin_solicitacoes_lojas_bloc.dart';

/// {@template admin_solicitacoes_lojas_state}
/// AdminSolicitacoesLojasState description
/// {@endtemplate}
class AdminSolicitacoesLojasState extends Equatable {
  /// {@macro admin_solicitacoes_lojas_state}
  const AdminSolicitacoesLojasState({
    this.customProperty = 'Default Value',
  });

  /// A description for customProperty
  final String customProperty;

  @override
  List<Object> get props => [customProperty];

  /// Creates a copy of the current AdminSolicitacoesLojasState with property changes
  AdminSolicitacoesLojasState copyWith({
    String? customProperty,
  }) {
    return AdminSolicitacoesLojasState(
      customProperty: customProperty ?? this.customProperty,
    );
  }
}

/// {@template admin_solicitacoes_lojas_initial}
/// The initial state of AdminSolicitacoesLojasState
/// {@endtemplate}
class AdminSolicitacoesLojasInitial extends AdminSolicitacoesLojasState {
  /// {@macro admin_solicitacoes_lojas_initial}
  const AdminSolicitacoesLojasInitial() : super();
}
