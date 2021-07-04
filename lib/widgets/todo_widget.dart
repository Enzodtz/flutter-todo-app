import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/bloc/todo_bloc.dart';
import 'package:todo_app/models/todo.dart';
import 'package:todo_app/routes/todo_details_route.dart';

class TodoWidget extends StatefulWidget {
  final Todo todo;
  TodoWidget({required this.todo});

  @override
  _TodoWidgetState createState() => _TodoWidgetState();
}

class _TodoWidgetState extends State<TodoWidget> {
  void checkboxOnChange(bool? val) {
    if (val != null) {
      final TodoBloc todoBloc = BlocProvider.of<TodoBloc>(context);
      todoBloc.add(
        TodoCheckbox(
          widget.todo.id,
          val,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () => Navigator.pushNamed(
        context,
        TodoDetailsRoute.PATH,
        arguments: TodoDetailsRouteArguments(widget.todo),
      ),
      trailing: Checkbox(
        value: widget.todo.completed,
        onChanged: checkboxOnChange,
      ),
      title: Container(
        width: MediaQuery.of(context).size.width,
        child: Text(
          widget.todo.title,
          style: Theme.of(context).textTheme.headline6,
        ),
      ),
      subtitle: Text(
        widget.todo.message,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: Theme.of(context).textTheme.subtitle1,
      ),
    );
  }
}
