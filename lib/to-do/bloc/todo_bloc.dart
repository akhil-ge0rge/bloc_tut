import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'todo_event.dart';
part 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  final List<String> tempTodo = [];
  TodoBloc() : super(const TodoState()) {
    on<AddTodoEvent>(_addTodo);
    on<RemoveTodoEvent>(_removeTodo);
  }

  void _addTodo(AddTodoEvent event, Emitter<TodoState> emit) {
    tempTodo.add(event.task);
    emit(state.copyWith(todo: List.from(tempTodo)));
  }

  void _removeTodo(RemoveTodoEvent event, Emitter<TodoState> emit) {
    tempTodo.remove(event.task);
    emit(state.copyWith(todo: List.from(tempTodo)));
  }
}
