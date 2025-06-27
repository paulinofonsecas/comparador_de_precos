part of 'admin_gestao_lojas_bloc.dart';

abstract class AdminGestaoLojasEvent  extends Equatable {
  const AdminGestaoLojasEvent();

  @override
  List<Object> get props => [];

}

/// {@template custom_admin_gestao_lojas_event}
/// Event added when some custom logic happens
/// {@endtemplate}
class CustomAdminGestaoLojasEvent extends AdminGestaoLojasEvent {
  /// {@macro custom_admin_gestao_lojas_event}
  const CustomAdminGestaoLojasEvent();
}
