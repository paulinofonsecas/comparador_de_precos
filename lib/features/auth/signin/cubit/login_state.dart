part of 'login_cubit.dart';

sealed class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

final class LoginInitial extends LoginState {}

final class LogoutLoading extends LoginState {}

final class LoginFailure extends LoginState {  const LoginFailure(this.message);

  final String message;

  @override
  List<Object> get props => [message];
}

final class LogoutSuccess extends LoginState {}
