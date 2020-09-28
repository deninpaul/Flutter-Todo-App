import 'package:flutter/material.dart';
import 'package:todo/Data/model.dart';
import 'package:todo/Services/database.dart';
import 'package:todo/UI/Utils/theme.dart';

class UpdateTodoForm extends StatefulWidget {
  UpdateTodoForm({Key key, this.entry, this.listUpdator}) : super(key: key);
  final TodoEntry entry;
  final VoidCallback listUpdator;

  @override
  _UpdateTodoFormState createState() => _UpdateTodoFormState();
}

class _UpdateTodoFormState extends State<UpdateTodoForm> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController titleController = TextEditingController();
  TextEditingController desController = TextEditingController();
  var db = DBProvider.db;

  @override
  void initState() {
    super.initState();
    titleController.text = widget.entry.title;
    desController.text = widget.entry.description;
  }

  @override
  Widget build(BuildContext context) {
    titleController.text = widget.entry.title;
    desController.text = widget.entry.title;
    return AlertDialog(
      content: Container(
        width: 300,
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Edit To-do",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: blue,
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.delete_outline),
                      onPressed: () => onPressedDelete(),
                      color: Colors.red,
                    ),
                  ],
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
                      onPressedUpdate();
                    }
                  },
                  child: Text("Update"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  onPressedCancel() {
    Navigator.pop(context);
  }

  onPressedUpdate() async {
    widget.entry.title = titleController.text;
    widget.entry.description = desController.text;

    db.updateTodoEntry(widget.entry);
    widget.listUpdator();
    Navigator.pop(context);
  }

  onPressedDelete() async {
    db.deleteTodoEntry(widget.entry.id);
    widget.listUpdator();
    Navigator.pop(context);
  }
}
