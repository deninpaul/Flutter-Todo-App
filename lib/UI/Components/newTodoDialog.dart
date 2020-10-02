import 'package:DSCtodo/Data/todoListClass.dart';
import 'package:DSCtodo/Services/localDatabase.dart';
import 'package:DSCtodo/UI/Utils/theme.dart';
import 'package:flutter/material.dart';

import '../home.dart';

class NewTodoDialog extends StatefulWidget {
  NewTodoDialog({Key key}) : super(key: key);

  @override
  _NewTodoDialogState createState() => _NewTodoDialogState();
}

class _NewTodoDialogState extends State<NewTodoDialog> {
  @override
  final _formKey = GlobalKey<FormState>();
  var db = DBProvider.db;
  TextEditingController titleTextController = new TextEditingController();
  TextEditingController descTextController = new TextEditingController();

  Widget build(BuildContext context) {
    return AlertDialog(
      content: Container(
        width: 300,
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                "New To-do",
                style: TextStyle(
                  color: blue,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: titleTextController,
                  decoration: InputDecoration(
                    labelText: "Title",
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: descTextController,
                  decoration: InputDecoration(
                    labelText: "Description",
                  ),
                ),
              ),
              SizedBox(
                height: 16,
              ),
              Container(
                padding: EdgeInsets.all(8.0),
                width: 200,
                child: RaisedButton(
                  color: blue,
                  child: Text(
                    "Create",
                    style: TextStyle(color: white),
                  ),
                  onPressed: () {
                    if (_formKey.currentState.validate()) {
                      newEntryCreation();
                    }
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  newEntryCreation() {
    String newTitle = titleTextController.text;
    String newDesc = descTextController.text;
    TodoEntry entry = TodoEntry(
      title: newTitle,
      description: newDesc,
      done: 0,
    );
    db.newTodoEntry(entry);
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => Home()), (route) => false);
  }
}
