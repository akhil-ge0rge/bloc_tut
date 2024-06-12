part of 'todo_bloc.dart';

class TodoState extends Equatable {
  final List todo;
  const TodoState({this.todo = const []});

  TodoState copyWith({List? todo}) {
    return TodoState(todo: todo ?? this.todo);
  }

  @override
  List<Object> get props => [todo];
}
