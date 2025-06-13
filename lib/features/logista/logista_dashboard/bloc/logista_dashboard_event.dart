part of 'logista_dashboard_bloc.dart';

abstract class LogistaDashboardEvent  extends Equatable {
  const LogistaDashboardEvent();

  @override
  List<Object> get props => [];

}

/// {@template custom_logista_dashboard_event}
/// Event added when some custom logic happens
/// {@endtemplate}
class CustomLogistaDashboardEvent extends LogistaDashboardEvent {
  /// {@macro custom_logista_dashboard_event}
  const CustomLogistaDashboardEvent();
}

class LoadProfileInfoLogistaEvent extends LogistaDashboardEvent {
  const LoadProfileInfoLogistaEvent({required this.userId});

  final String userId;

  @override
  List<Object> get props => [userId];
}
