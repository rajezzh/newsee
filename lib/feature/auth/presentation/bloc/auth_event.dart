part of 'auth_bloc.dart';

sealed class AuthEvent {}

final class LoginWithAccount extends AuthEvent {
  final LoginRequest loginRequest;

  LoginWithAccount({required this.loginRequest});
}
