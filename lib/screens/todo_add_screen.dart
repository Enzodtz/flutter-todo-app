import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:todo_app/bloc/todo_bloc.dart';
import 'package:todo_app/models/todo.dart';

class TodoAddScreen extends StatefulWidget {
  TodoAddScreen();

  @override
  _TodoAddScreenState createState() => _TodoAddScreenState();
}

class _TodoAddScreenState extends State<TodoAddScreen> {
  final _formKey = GlobalKey<FormBuilderState>();

  void submitForm(BuildContext context) {
    if (_formKey.currentState?.saveAndValidate() ?? false) {
      Map<String, dynamic> form = _formKey.currentState!.value;
      final TodoBloc todoBloc = BlocProvider.of<TodoBloc>(context);
      todoBloc.add(AddTodo(form));
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Todo"),
        titleSpacing: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          splashRadius: 20,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => submitForm(context),
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: FormBuilder(
              key: _formKey,
              initialValue: {},
              skipDisabled: true,
              child: Column(
                children: <Widget>[
                  FormBuilderTextField(
                    name: 'title',
                    validator: FormBuilderValidators.compose(
                      [
                        FormBuilderValidators.required(context),
                      ],
                    ),
                    decoration: InputDecoration(
                      labelText: 'Title',
                    ),
                    textInputAction: TextInputAction.next,
                  ),
                  FormBuilderTextField(
                    name: 'message',
                    validator: FormBuilderValidators.compose(
                      [
                        FormBuilderValidators.required(context),
                      ],
                    ),
                    minLines: 1,
                    maxLines: 5,
                    decoration: InputDecoration(
                      labelText: 'Message',
                    ),
                    textInputAction: TextInputAction.next,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
