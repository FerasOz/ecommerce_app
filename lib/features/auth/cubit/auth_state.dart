abstract class AuthState {}

class AuthInitial extends AuthState {}

class LoadingAuthState extends AuthState {}

class SuccessAuthState extends AuthState {
  final String message;
  SuccessAuthState(this.message);
}

class ErrorAuthState extends AuthState {
  final String message;
  ErrorAuthState(this.message);
}
