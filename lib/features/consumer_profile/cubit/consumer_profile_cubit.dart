import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
part 'consumer_profile_state.dart';

class ConsumerProfileCubit extends Cubit<ConsumerProfileState> {
  ConsumerProfileCubit() : super(const ConsumerProfileInitial());

  /// A description for yourCustomFunction 
  FutureOr<void> yourCustomFunction() {
    // TODO: Add Logic
  }
}
