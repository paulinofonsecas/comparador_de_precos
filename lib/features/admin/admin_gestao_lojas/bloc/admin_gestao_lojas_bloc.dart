import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
part 'admin_gestao_lojas_event.dart';
part 'admin_gestao_lojas_state.dart';

class AdminGestaoLojasBloc extends Bloc<AdminGestaoLojasEvent, AdminGestaoLojasState> {
  AdminGestaoLojasBloc() : super(const AdminGestaoLojasInitial()) {
    on<CustomAdminGestaoLojasEvent>(_onCustomAdminGestaoLojasEvent);
  }

  FutureOr<void> _onCustomAdminGestaoLojasEvent(
    CustomAdminGestaoLojasEvent event,
    Emitter<AdminGestaoLojasState> emit,
  ) {
    // TODO: Add Logic
  }
}
