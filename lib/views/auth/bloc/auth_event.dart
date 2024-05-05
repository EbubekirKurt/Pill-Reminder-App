part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

class CheckSessionAvailability extends AuthEvent {}

class SignUpEvent extends AuthEvent {
  final String name;
  final String password;
  final String email;

  SignUpEvent({
    required this.email,
    required this.name,
    required this.password,
  });
}

class LoginEvent extends AuthEvent {
  final String password;
  final String email;

  LoginEvent({
    required this.email,
    required this.password,
  });
}

class LogoutEvent extends AuthEvent {}

final class SendOtpEvent extends AuthEvent {
  final String email;

  SendOtpEvent({required this.email});
}

final class ResendOtpEvent extends AuthEvent {}

final class ConfirmOtpEvent extends AuthEvent {
  final String email;
  final String otpToken;

  ConfirmOtpEvent({required this.email, required this.otpToken});
}

final class ChangePasswordEvent extends AuthEvent {
  final String password;
  final String confirmPassword;

  ChangePasswordEvent({required this.password, required this.confirmPassword});
}
