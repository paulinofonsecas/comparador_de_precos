import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
part 'admin_dashboard_event.dart';
part 'admin_dashboard_state.dart';

class AdminDashboardBloc extends Bloc<AdminDashboardEvent, AdminDashboardState> {
  AdminDashboardBloc() : super(const AdminDashboardInitial()) {
    on<CustomAdminDashboardEvent>(_onCustomAdminDashboardEvent);
  }

  FutureOr<void> _onCustomAdminDashboardEvent(
    CustomAdminDashboardEvent event,
    Emitter<AdminDashboardState> emit,
  ) {
    // TODO: Add Logic
  }
}
