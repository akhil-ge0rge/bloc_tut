import 'package:bloc_tut/counter/bloc/counter_bloc.dart';
import 'package:bloc_tut/fav/bloc/fav_bloc.dart';
import 'package:bloc_tut/fav/repository/fav_repository.dart';
import 'package:bloc_tut/image_picker/bloc/image_picker_bloc.dart';
import 'package:bloc_tut/image_picker/utils/image_picker_utils.dart';
import 'package:bloc_tut/login/bloc/login_bloc.dart';
import 'package:bloc_tut/post/bloc/post_bloc.dart';
import 'package:bloc_tut/post/post_screen.dart';
import 'package:bloc_tut/post/repository/post_repository.dart';
import 'package:bloc_tut/switch/bloc/switch_bloc.dart';
import 'package:bloc_tut/switch/switch_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'counter/counter_screen.dart';
import 'fav/fav_screen.dart';
import 'image_picker/image_picker_screen.dart';
import 'login/screen/login_screen.dart';
import 'to-do/bloc/todo_bloc.dart';
import 'to-do/todo_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => CounterBloc(),
        ),
        BlocProvider(
          create: (_) => SwitchBloc(),
        ),
        BlocProvider(
          create: (_) => TodoBloc(),
        ),
        BlocProvider(
          create: (_) => PostBloc(postRepository: PostRepository()),
        ),
        BlocProvider(
          create: (_) => FavBloc(favRepository: FavRepository()),
        ),
        BlocProvider(
          create: (_) => ImagePickerBloc(
            imagePickerUtils: ImagePickerUtils(),
          ),
        ),
        BlocProvider(
          create: (_) => LoginBloc(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          brightness: Brightness.dark,
          useMaterial3: true,
        ),
        home: const LoginScreen(),
      ),
    );
  }
}
