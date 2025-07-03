part of 'admin_solicitacoes_lojas_bloc.dart';

abstract class AdminSolicitacoesLojasEvent  extends Equatable {
  const AdminSolicitacoesLojasEvent();

  @override
  List<Object> get props => [];

}

/// {@template custom_admin_solicitacoes_lojas_event}
/// Event added when some custom logic happens
/// {@endtemplate}
class CustomAdminSolicitacoesLojasEvent extends AdminSolicitacoesLojasEvent {
  /// {@macro custom_admin_solicitacoes_lojas_event}
  const CustomAdminSolicitacoesLojasEvent();
}
