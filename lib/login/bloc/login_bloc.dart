import 'dart:convert';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart' as http;

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(const LoginState()) {
    on<EmailChangedEvent>(_emailChange);
    on<PasswordChangedEvent>(_passwordChange);
    on<LoginButtonEvent>(_login);
  }

  void _emailChange(EmailChangedEvent event, Emitter<LoginState> emit) {
    emit(state.copyWith(email: event.email));
  }

  void _passwordChange(PasswordChangedEvent event, Emitter<LoginState> emit) {
    emit(state.copyWith(password: event.password));
  }

  void _login(LoginButtonEvent event, Emitter<LoginState> emit) async {
    final body = {"email": state.email, "password": state.password};
    log(body.toString());
    emit(state.copyWith(loginStatus: LoginStatus.loading));
    try {
      final response = await http.post(
        Uri.parse('https://reqres.in/api/login'),
        body: body,
      );

      log(response.statusCode.toString());
      log(response.body.toString());
      var data = jsonDecode(response.body);
      if (response.statusCode == 201 || response.statusCode == 200) {
        emit(state.copyWith(
            loginStatus: LoginStatus.sucess, message: 'Login Sucessful'));
      } else {
        emit(state.copyWith(
            message: data['error'], loginStatus: LoginStatus.error));
      }
    } catch (e) {
      emit(state.copyWith(
          message: e.toString(), loginStatus: LoginStatus.error));
    }
  }
}
