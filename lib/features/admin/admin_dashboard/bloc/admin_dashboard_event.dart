part of 'admin_dashboard_bloc.dart';

abstract class AdminDashboardEvent  extends Equatable {
  const AdminDashboardEvent();

  @override
  List<Object> get props => [];

}

/// {@template custom_admin_dashboard_event}
/// Event added when some custom logic happens
/// {@endtemplate}
class CustomAdminDashboardEvent extends AdminDashboardEvent {
  /// {@macro custom_admin_dashboard_event}
  const CustomAdminDashboardEvent();
}
