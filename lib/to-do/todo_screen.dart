import 'package:bloc_tut/to-do/bloc/todo_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TodoScreen extends StatelessWidget {
  const TodoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<TodoBloc, TodoState>(
        builder: (context, state) {
          if (state.todo.isEmpty) {
            return const Center(
              child: Text("List Is Empty"),
            );
          } else if (state.todo.isNotEmpty) {
            return ListView.builder(
              itemCount: state.todo.length,
              itemBuilder: (context, index) => ListTile(
                title: Text("$index ${state.todo.elementAt(index)}"),
                trailing: IconButton(
                  onPressed: () {
                    context.read<TodoBloc>().add(
                        RemoveTodoEvent(task: state.todo.elementAt(index)));
                  },
                  icon: const Icon(
                    Icons.delete,
                  ),
                ),
              ),
            );
          } else {
            return const SizedBox();
          }
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          for (int i = 0; i < 10; i++) {
            context.read<TodoBloc>().add(AddTodoEvent(task: 'Task  $i'));
          }
        },
        label: const Icon(
          Icons.add,
        ),
      ),
    );
  }
}
