import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/bloc/todo_bloc.dart';
import 'package:todo_app/screens/todo_list_screen.dart';

class TodoListRoute {
  static const String PATH = '/';
  static MaterialPageRoute getRoute(TodoBloc todoBloc) {
    return MaterialPageRoute(
      builder: (_) => BlocProvider.value(
        value: todoBloc,
        child: TodoListScreen(),
      ),
    );
  }
}
