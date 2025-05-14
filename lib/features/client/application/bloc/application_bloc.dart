import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
part 'application_event.dart';
part 'application_state.dart';

class ApplicationBloc extends Bloc<ApplicationEvent, ApplicationState> {
  ApplicationBloc() : super(const ApplicationInitial()) {
    on<CustomApplicationEvent>(_onCustomApplicationEvent);
  }

  FutureOr<void> _onCustomApplicationEvent(
    CustomApplicationEvent event,
    Emitter<ApplicationState> emit,
  ) {
    // TODO: Add Logic
  }
}
