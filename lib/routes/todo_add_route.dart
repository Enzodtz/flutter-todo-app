import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/bloc/todo_bloc.dart';
import 'package:todo_app/screens/todo_add_screen.dart';

class TodoAddRoute {
  static const String PATH = '/add';
  static MaterialPageRoute getRoute(TodoBloc todoBloc) {
    return MaterialPageRoute(
      builder: (_) => BlocProvider.value(
        value: todoBloc,
        child: TodoAddScreen(),
      ),
    );
  }
}
