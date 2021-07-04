part of 'todo_bloc.dart';

@immutable
abstract class TodoState {
  const TodoState();
}

class TodoList extends TodoState {
  final List<Todo> todos;

  TodoList({required this.todos});
}
