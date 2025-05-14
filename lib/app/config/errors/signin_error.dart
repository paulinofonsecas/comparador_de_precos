class SigninError {
  SigninError(this.message);

  final String message;

  @override
  String toString() => 'SigninError: $message';
}