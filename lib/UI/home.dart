import 'package:DSCtodo/UI/Components/todoListTile.dart';
import 'package:flutter/material.dart';
import 'Utils/theme.dart';

class Home extends StatelessWidget {
  const Home({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(),
      body: Container(
        color: lightGray,
        child: todoListTiles(),
      ),
    );
  }

  todoListTiles() {
    return ListView.builder(
      physics: BouncingScrollPhysics(),
      itemCount: 10,
      itemBuilder: (context, index) {
        return TodoListTile();
      },
    );
  }

  customAppBar() {
    return PreferredSize(
      preferredSize: Size.fromHeight(0.0),
      child: AppBar(
        backgroundColor: white,
      ),
    );
  }
}
