import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/bloc/todo_bloc.dart';
import 'package:todo_app/routes/todo_add_route.dart';
import 'package:todo_app/routes/todo_details_route.dart';
import 'package:todo_app/routes/todo_list_route.dart';

class AppRouter {
  late final TodoBloc todoBloc = TodoBloc();

  Route onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case TodoListRoute.PATH:
        return TodoListRoute.getRoute(todoBloc);
      case TodoDetailsRoute.PATH:
        return TodoDetailsRoute.getRoute(settings, todoBloc);
      case TodoAddRoute.PATH:
        return TodoAddRoute.getRoute(todoBloc);
      default:
        return MaterialPageRoute(
          builder: (_) => Container(),
        );
    }
  }
}
