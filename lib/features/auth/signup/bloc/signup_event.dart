part of 'signup_bloc.dart';

abstract class SignupEvent extends Equatable {
  const SignupEvent();

  @override
  List<Object> get props => [];
}

/// {@template custom_signup_event}
/// Event added when some custom logic happens
/// {@endtemplate}
class CustomSignupEvent extends SignupEvent {
  /// {@macro custom_signup_event}
  const CustomSignupEvent();
}

class CadastrarNovoUsuarioEvent extends SignupEvent {
  const CadastrarNovoUsuarioEvent(this.newUserFormParam);

  final NewUserFormParam newUserFormParam;

  @override
  List<Object> get props => [newUserFormParam];
}
