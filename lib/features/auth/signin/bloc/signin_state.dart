part of 'signin_bloc.dart';

/// {@template signin_state}
/// SigninState description
/// {@endtemplate}
class SigninState extends Equatable {
  /// {@macro signin_state}
  const SigninState({
    this.customProperty = 'Default Value',
  });

  /// A description for customProperty
  final String customProperty;

  @override
  List<Object> get props => [customProperty];

  /// Creates a copy of the current SigninState with property changes
  SigninState copyWith({
    String? customProperty,
  }) {
    return SigninState(
      customProperty: customProperty ?? this.customProperty,
    );
  }
}

/// {@template signin_initial}
/// The initial state of SigninState
/// {@endtemplate}
class SigninInitial extends SigninState {
  /// {@macro signin_initial}
  const SigninInitial() : super();
}

class SigninSuccess extends SigninState {
  const SigninSuccess(this.user) : super();

  final MyUser user;

  @override
  List<Object> get props => [user];
}

class SigninLoading extends SigninState {
  const SigninLoading() : super();
}

class SigninError extends SigninState {
  const SigninError(this.error) : super();

  final String error;

  @override
  List<Object> get props => [error];
}