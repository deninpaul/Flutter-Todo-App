import 'package:flutter/material.dart';
import 'package:todo/Data/model.dart';
import 'package:todo/Services/database.dart';
import 'package:todo/UI/Components/viewDialog.dart';
import 'package:todo/UI/Utils/global.dart';
import 'package:todo/UI/Utils/theme.dart';

class TodoListTile extends StatefulWidget {
  final TodoEntry entry;
  final VoidCallback listUpdator;

  TodoListTile({Key key, this.entry, this.listUpdator}) : super(key: key);

  @override
  _TodoListTileState createState() => _TodoListTileState();
}

class _TodoListTileState extends State<TodoListTile> {
  double diameter = 28;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 12, left: 26, right: 26),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: widget.entry.done == 1 ? lightgrey : shadowColor,
            blurRadius: 8.0,
            offset: Offset(0, 3),
          )
        ],
      ),
      child: FlatButton(
        color: white,
        onPressed: () {
          showDialog(
            context: context,
            child: UpdateTodoForm(
              entry: widget.entry,
              listUpdator: widget.listUpdator,
            ),
          );
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
        ),
        padding: EdgeInsets.zero,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 24, top: 22, bottom: 22),
                child: AnimatedOpacity(
                  opacity: widget.entry.done == 1 ? 0.3 : 1.0,
                  duration: Duration(milliseconds: 200),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (widget.entry.title != null)
                        Text(
                          widget.entry.title,
                          style: titleStyle(),
                        ),
                      SizedBox(
                        height: 3,
                      ),
                      if (widget.entry.description != null)
                        Text(
                          widget.entry.description,
                          style: bodyStyle(),
                        ),
                    ],
                  ),
                ),
              ),
            ),
            FlatButton(
              child: widget.entry.done == 1 ? circleOn() : circleOff(),
              splashColor: white,
              focusColor: white,
              onPressed: () {
                setState(() {
                  widget.entry.done = widget.entry.done == 1 ? 0 : 1;
                  DBProvider.db.updateTodoEntry(widget.entry);
                  widget.listUpdator();
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  titleStyle() {
    return TextStyle(
        fontFamily: primaryFont,
        fontSize: 16,
        color: blue,
        height: 1.3,
        decoration: widget.entry.done == 1
            ? TextDecoration.lineThrough
            : TextDecoration.none,
        fontWeight: FontWeight.w600);
  }

  bodyStyle() {
    return TextStyle(
        fontFamily: primaryFont,
        fontSize: 11.5,
        color: black,
        height: 1.5,
        decoration: widget.entry.done == 1
            ? TextDecoration.lineThrough
            : TextDecoration.none,
        fontWeight: FontWeight.w400);
  }

  circleOn() {
    return Container(
      width: diameter,
      height: diameter,
      padding: EdgeInsets.all(7),
      decoration: BoxDecoration(
        color: blue,
        shape: BoxShape.circle,
      ),
      child: Image.asset(tickAssetPath),
    );
  }

  circleOff() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20),
      child: Container(
        width: diameter,
        height: diameter,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(width: 2.5, color: blue),
        ),
      ),
    );
  }
}
