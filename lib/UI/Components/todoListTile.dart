import 'package:DSCtodo/UI/Utils/global.dart';
import 'package:DSCtodo/UI/Utils/theme.dart';
import 'package:flutter/material.dart';

class TodoListTile extends StatefulWidget {
  TodoListTile({Key key}) : super(key: key);

  @override
  _TodoListTileState createState() => _TodoListTileState();
}

class _TodoListTileState extends State<TodoListTile> {
  final double diameter = 30;
  bool done = true;
  String title = "Take Medicine";
  String description = "Hello World baaa baa ba baaaaaaaaaa";

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
              opacity: !done ? 1 : 0.4,
              duration: Duration(milliseconds: 150),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      decoration: done
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
                    description,
                    style: TextStyle(
                      decoration: done
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
                done = !done;
              });
            },
            child: done ? circleDone() : circleNotDone(),
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
