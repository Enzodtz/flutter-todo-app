import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:todo_app/models/todo.dart';

class TodoDetailsScreen extends StatefulWidget {
  final Todo todo;

  TodoDetailsScreen(this.todo);

  @override
  _TodoDetailsScreenState createState() => _TodoDetailsScreenState();
}

class _TodoDetailsScreenState extends State<TodoDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Todo Details"),
        titleSpacing: 0,
        actions: [
          IconButton(
            onPressed: () {},
            splashRadius: 20,
            icon: Icon(Icons.edit),
          ),
        ],
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          splashRadius: 20,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: FormBuilder(
              initialValue: {
                'title': widget.todo.title,
                'message': widget.todo.message,
                'completed': widget.todo.completed
              },
              enabled: false,
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
                  FormBuilderCheckbox(
                    initialValue: widget.todo.completed,
                    name: 'completed',
                    title: Text('Completed'),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
