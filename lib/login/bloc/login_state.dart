part of 'login_bloc.dart';

enum LoginStatus { initial, loading, sucess, error }

class LoginState extends Equatable {
  final LoginStatus loginStatus;
  final String message;
  final String email;
  final String password;
  const LoginState({
    this.email = '',
    this.message = '',
    this.password = '',
    this.loginStatus = LoginStatus.initial,
  });

  LoginState copyWith({
    LoginStatus? loginStatus,
    String? message,
    String? email,
    String? password,
  }) {
    return LoginState(
      email: email ?? this.email,
      loginStatus: loginStatus ?? this.loginStatus,
      message: message ?? this.message,
      password: password ?? this.password,
    );
  }

  @override
  List<Object> get props => [email, loginStatus, password, message];
}
