import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/bloc/todo_bloc.dart';
import 'package:todo_app/models/todo.dart';
import 'package:todo_app/routes/todo_add_route.dart';
import 'package:todo_app/widgets/todo_widget.dart';

class TodoListScreen extends StatefulWidget {
  @override
  _TodoListScreenState createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Todos"),
        actions: [
          IconButton(
            splashRadius: 20,
            onPressed: () {
              Navigator.pushNamed(context, TodoAddRoute.PATH);
            },
            icon: Icon(Icons.add),
          )
        ],
      ),
      body: BlocBuilder<TodoBloc, TodoState>(
        builder: (context, state) {
          if (state is TodoList) {
            return buildTodoList(state.todos);
          } else {
            return Container();
          }
        },
      ),
    );
  }

  Widget buildTodoList(List<Todo> todos) {
    return ListView.builder(
      itemCount: todos.length,
      itemBuilder: (BuildContext context, int index) {
        return TodoWidget(
          todo: todos[index],
        );
      },
    );
  }
}
