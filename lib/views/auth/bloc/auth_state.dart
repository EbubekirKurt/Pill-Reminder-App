part of 'auth_bloc.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

final class AuthLoadingState extends AuthState {}

final class AuthSuccessState extends AuthState {
  final String msg;
  AuthSuccessState({required this.msg});
}

final class AuthErrorState extends AuthState {
  final String msg;
  AuthErrorState({required this.msg});
}

final class SessionAvailabilityState extends AuthState {
  final dynamic isAvailable;
  SessionAvailabilityState({required this.isAvailable});
}

