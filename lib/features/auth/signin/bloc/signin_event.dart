part of 'signin_bloc.dart';

abstract class SigninEvent extends Equatable {
  const SigninEvent();

  @override
  List<Object> get props => [];
}

/// {@template custom_signin_event}
/// Event added when some custom logic happens
/// {@endtemplate}
class SignInWithPasswordEvent extends SigninEvent {
  /// {@macro custom_signin_event}
  const SignInWithPasswordEvent();
}

class SigninWithEmailAndPasswordEvent extends SigninEvent {
  const SigninWithEmailAndPasswordEvent({
    required this.email,
    required this.password,
  });

  final String email;
  final String password;

  @override
  List<Object> get props => [email, password];
}

// check user is local login saved
class CheckUserLocalLoginEvent extends SigninEvent {
  const CheckUserLocalLoginEvent();
}