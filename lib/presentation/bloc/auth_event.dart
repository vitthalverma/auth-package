part of 'auth_bloc.dart';

sealed class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class AuthStateChangedEvent extends AuthEvent {
  final UserEntity? user;
  const AuthStateChangedEvent(this.user);

  @override
  List<Object> get props => [user!];
}

class LogInEvent extends AuthEvent {
  final String email;
  final String password;

  const LogInEvent({required this.email, required this.password});

  @override
  List<Object> get props => [email, password];
}

class RegisterEvent extends AuthEvent {
  final String name;
  final String email;
  final String password;

  const RegisterEvent({required this.email, required this.password, required this.name});

  @override
  List<Object> get props => [email, password, name];
}

class LogOutEvent extends AuthEvent {}
