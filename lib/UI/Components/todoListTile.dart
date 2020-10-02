import 'package:DSCtodo/Data/todoListClass.dart';
import 'package:DSCtodo/Services/localDatabase.dart';
import 'package:DSCtodo/UI/Utils/global.dart';
import 'package:DSCtodo/UI/Utils/theme.dart';
import 'package:DSCtodo/UI/home.dart';
import 'package:flutter/material.dart';

class TodoListTile extends StatefulWidget {
  TodoListTile({this.entry, Key key}) : super(key: key);

  final TodoEntry entry;

  @override
  _TodoListTileState createState() => _TodoListTileState();
}

class _TodoListTileState extends State<TodoListTile> {
  final double diameter = 30;
  var db = DBProvider.db;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(26, 0, 26, 12),
      padding: EdgeInsets.fromLTRB(24, 16, 0, 16),
      decoration: new BoxDecoration(
        color: white,
        borderRadius: BorderRadius.all(Radius.circular(4)),
        boxShadow: [
          BoxShadow(
            color: darkGray,
            blurRadius: 12,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: AnimatedOpacity(
              opacity: widget.entry.done == 1 ? 0.4 : 1,
              duration: Duration(milliseconds: 150),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.entry.title == null ? " " : widget.entry.title,
                    style: TextStyle(
                      decoration: widget.entry.done == 1
                          ? TextDecoration.lineThrough
                          : TextDecoration.none,
                      color: blue,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(
                    height: 3.5,
                  ),
                  Text(
                    widget.entry.description == null
                        ? " "
                        : widget.entry.description,
                    style: TextStyle(
                      decoration: widget.entry.done == 1
                          ? TextDecoration.lineThrough
                          : TextDecoration.none,
                      fontSize: 12,
                      color: black,
                    ),
                  ),
                ],
              ),
            ),
          ),
          FlatButton(
            onPressed: () {
              setState(() {
                widget.entry.done = widget.entry.done == 1 ? 0 : 1;
                db.updateTodoEntry(widget.entry);
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => Home()),
                    (route) => false);
              });
            },
            child: widget.entry.done == 1 ? circleDone() : circleNotDone(),
          ),
        ],
      ),
    );
  }

  circleNotDone() {
    return Container(
      height: diameter,
      width: diameter,
      margin: EdgeInsets.symmetric(vertical: 20),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: blue, width: 2),
      ),
    );
  }

  circleDone() {
    return Container(
      height: diameter,
      width: diameter,
      margin: EdgeInsets.symmetric(vertical: 20),
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: blue,
      ),
      child: Image.asset(
        tickImagePath,
      ),
    );
  }
}
