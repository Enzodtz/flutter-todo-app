import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/bloc/todo_bloc.dart';
import 'package:todo_app/models/todo.dart';
import 'package:todo_app/screens/todo_details_screen.dart';

class TodoDetailsRouteArguments {
  final Todo todo;

  TodoDetailsRouteArguments(this.todo);
}

class TodoDetailsRoute {
  static const String PATH = '/details';
  static MaterialPageRoute getRoute(RouteSettings settings, TodoBloc todoBloc) {
    return MaterialPageRoute(
      builder: (_) {
        final args = settings.arguments as TodoDetailsRouteArguments;

        return BlocProvider.value(
          value: todoBloc,
          child: TodoDetailsScreen(args.todo),
        );
      },
    );
  }
}
