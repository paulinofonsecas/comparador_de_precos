import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
part 'logista_dashboard_event.dart';
part 'logista_dashboard_state.dart';

class LogistaDashboardBloc
    extends Bloc<LogistaDashboardEvent, LogistaDashboardState> {
  LogistaDashboardBloc()
      : super(const LogistaDashboardInitial()) {
    on<CustomLogistaDashboardEvent>(_onCustomLogistaDashboardEvent);
  }

  FutureOr<void> _onCustomLogistaDashboardEvent(
    CustomLogistaDashboardEvent event,
    Emitter<LogistaDashboardState> emit,
  ) {
    // TODO: Add Logic
  }
}
