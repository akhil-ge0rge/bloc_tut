// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'login_bloc.dart';

sealed class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class EmailChangedEvent extends LoginEvent {
  final String email;
  const EmailChangedEvent({
    required this.email,
  });
  @override
  List<Object> get props => [email];
}

class PasswordChangedEvent extends LoginEvent {
  final String password;
  const PasswordChangedEvent({
    required this.password,
  });
  @override
  List<Object> get props => [password];
}

class LoginButtonEvent extends LoginEvent {}
