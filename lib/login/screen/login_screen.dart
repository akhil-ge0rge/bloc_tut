import 'dart:developer';

import 'package:bloc_tut/login/bloc/login_bloc.dart';
import 'package:bloc_tut/post/bloc/post_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late LoginBloc _loginBloc;
  FocusNode _emailNode = FocusNode();
  FocusNode _passwordNode = FocusNode();
  @override
  void initState() {
    _loginBloc = LoginBloc();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _loginBloc,
      child: Scaffold(
        appBar: AppBar(),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BlocBuilder<LoginBloc, LoginState>(
              buildWhen: (previous, current) => previous.email != current.email,
              builder: (context, state) {
                return TextFormField(
                  focusNode: _emailNode,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Email",
                  ),
                  onChanged: (value) {
                    context
                        .read<LoginBloc>()
                        .add(EmailChangedEvent(email: value));
                  },
                  onFieldSubmitted: (value) {},
                );
              },
            ),
            const SizedBox(
              height: 30,
            ),
            BlocBuilder<LoginBloc, LoginState>(
              buildWhen: (previous, current) =>
                  previous.password != current.password,
              builder: (context, state) {
                return TextFormField(
                  focusNode: _passwordNode,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Password",
                  ),
                  onChanged: (value) {
                    context
                        .read<LoginBloc>()
                        .add(PasswordChangedEvent(password: value));
                  },
                  onFieldSubmitted: (value) {},
                );
              },
            ),
            const SizedBox(
              height: 50,
            ),
            BlocListener<LoginBloc, LoginState>(
              listener: (context, state) {
                if (state.loginStatus == LoginStatus.error ||
                    state.loginStatus == LoginStatus.sucess) {
                  ScaffoldMessenger.of(context)
                    ..hideCurrentSnackBar()
                    ..showSnackBar(
                      SnackBar(
                        content: Text(state.message),
                      ),
                    );
                }
              },
              child: BlocBuilder<LoginBloc, LoginState>(
                  buildWhen: (previous, current) =>
                      previous.loginStatus != current.loginStatus,
                  builder: (context, state) {
                    log(state.loginStatus.toString());
                    return ElevatedButton(
                      onPressed: () {
                        context.read<LoginBloc>().add(LoginButtonEvent());
                      },
                      child: state.loginStatus == LoginStatus.loading
                          ? CircularProgressIndicator.adaptive()
                          : Text("L O G I N"),
                    );
                  }),
            )
          ],
        ),
      ),
    );
  }
}
