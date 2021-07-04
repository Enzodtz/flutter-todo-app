import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:todo_app/models/todo.dart';

part 'todo_event.dart';
part 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  TodoBloc() : super(TodoList(todos: []));

  @override
  Stream<TodoState> mapEventToState(
    TodoEvent event,
  ) async* {
    if (event is AddTodo) {
      yield* _mapAddTodoToState(event);
    } else if (event is TodoCheckbox) {
      yield* _mapTodoCheckboxToState(event);
    }
  }

  Stream<TodoState> _mapTodoCheckboxToState(TodoCheckbox event) async* {
    final List<Todo> todos = (state as TodoList).todos;
    final int index = todos.indexWhere((Todo todo) => todo.id == event.id);
    todos[index].completed = event.value;
    yield TodoList(
      todos: todos,
    );
  }

  Stream<TodoState> _mapAddTodoToState(AddTodo event) async* {
    final List<Todo> todos = (state as TodoList).todos;
    final Todo todo = Todo(
      id: todos.length,
      title: event.form['title'],
      message: event.form['message'],
    );
    todos.add(todo);
    yield TodoList(
      todos: todos,
    );
  }
}
