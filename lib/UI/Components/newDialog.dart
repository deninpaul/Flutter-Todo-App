import 'package:flutter/material.dart';
import 'package:todo/Data/model.dart';
import 'package:todo/Services/database.dart';
import 'package:todo/UI/Utils/theme.dart';

class NewTodoForm extends StatefulWidget {
  NewTodoForm({Key key, this.listUpdator}) : super(key: key);
  final VoidCallback listUpdator;

  @override
  _NewTodoFormState createState() => _NewTodoFormState();
}

class _NewTodoFormState extends State<NewTodoForm> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController titleController = TextEditingController();
  TextEditingController desController = TextEditingController();

  @override
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
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: blue,
                ),
              ),
              SizedBox(height: 10),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: titleController,
                  style: TextStyle(color: blue, fontWeight: FontWeight.w500),
                  cursorColor: blue,
                  decoration: InputDecoration(
                    labelText: "Title",
                    focusColor: blue,
                  ),
                  validator: (text) {
                    if (text == null || text.isEmpty) {
                      return "Don't leave this empty";
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: desController,
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  style: TextStyle(fontSize: 12),
                  decoration: InputDecoration(
                    labelText: "Description",
                    focusColor: blue,
                  ),
                  validator: (text) {
                    if (text == null || text.isEmpty) {
                      return "Don't leave this empty";
                    }
                    return null;
                  },
                ),
              ),
              SizedBox(height: 40),
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: FlatButton(
                  color: blue,
                  padding: EdgeInsets.symmetric(vertical: 12),
                  textColor: white,
                  onPressed: () {
                    if (_formKey.currentState.validate()) {
                      onPressedCreate();
                    }
                  },
                  child: Text("Create"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  onPressedCreate() async {
    TodoEntry entry = TodoEntry();
    entry.title = titleController.text;
    entry.description = desController.text;
    entry.done = 0;

    var db = DBProvider.db;
    db.newTodoEntry(entry);
    List<TodoEntry> temp = await db.getAllTodoEntries();
    print(temp.length);
    widget.listUpdator();
    Navigator.pop(context);
  }
}
