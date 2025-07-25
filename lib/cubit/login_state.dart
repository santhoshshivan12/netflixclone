import 'package:flutter/foundation.dart';

@immutable
abstract class LoginState {
  const LoginState();
}

class LoginInitial extends LoginState {
  const LoginInitial();
}

class LoginLoading extends LoginState {
  const LoginLoading();
}

class LoginSuccess extends LoginState {
  final String email;
  const LoginSuccess({required this.email});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LoginSuccess &&
          runtimeType == other.runtimeType &&
          email == other.email;

  @override
  int get hashCode => email.hashCode;
}

class LoginError extends LoginState {
  final String message;
  const LoginError({required this.message});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LoginError &&
          runtimeType == other.runtimeType &&
          message == other.message;

  @override
  int get hashCode => message.hashCode;
}

class LoggedOut extends LoginState {
  const LoggedOut();
} 