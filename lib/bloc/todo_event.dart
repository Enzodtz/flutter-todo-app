part of 'todo_bloc.dart';

@immutable
abstract class TodoEvent {
  const TodoEvent();
}

class AddTodo extends TodoEvent {
  final Map<String, dynamic> form;

  AddTodo(
    this.form,
  );
}

class TodoCheckbox extends TodoEvent {
  final int id;
  final bool value;

  TodoCheckbox(
    this.id,
    this.value,
  );
}
