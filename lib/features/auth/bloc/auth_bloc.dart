import 'package:bloc/bloc.dart';
import 'package:comparador_de_precos/data/repositories/authentication_repository.dart';
import 'package:equatable/equatable.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc({
    required this.authenticationRepository,
  }) : super(AuthInitial()) {
    on<SignOutEvent>(_onSignOut);
  }

  final IAuthenticationRepository authenticationRepository;

  Future<void> _onSignOut(SignOutEvent event, Emitter<AuthState> emit) async {
    try {
      emit(SignOutLoading());
      await authenticationRepository.signOut();
      emit(SignOutSuccess());
    } on Exception catch (e) {
      emit(SignOutFailure(e.toString()));
    }
  }
}
