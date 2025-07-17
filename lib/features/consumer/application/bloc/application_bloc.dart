import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
part 'application_event.dart';
part 'application_state.dart';

class ApplicationBloc extends Bloc<ApplicationEvent, ApplicationState> {
  ApplicationBloc() : super(const ApplicationInitial()) {
    on<ChangePageApplicationEvent>(_onChangePageApplicationEvent);
  }

  FutureOr<void> _onChangePageApplicationEvent(
    ChangePageApplicationEvent event,
    Emitter<ApplicationState> emit,
  ) {
    emit(ApplicationChangePage(index: event.page));
  }
}
