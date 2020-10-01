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
        child: CustomScrollView(
          physics: BouncingScrollPhysics(),
          slivers: [
            SliverAppBar(
              backgroundColor: white,
              floating: false,
              pinned: true,
              expandedHeight: 160,
              flexibleSpace: FlexibleSpaceBar(
                title: Text(
                  "todolist",
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 24,
                    color: blue,
                  ),
                ),
                centerTitle: true,
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  return TodoListTiles();
                },
                childCount: 1,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: customFAB(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  customFAB() {
    return GestureDetector(
      onTap: () {
        print("I am a button");
      },
      child: Container(
        height: 64,
        width: 64,
        margin: EdgeInsets.only(bottom: 14),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: blue,
          boxShadow: [
            BoxShadow(
              color: Colors.grey[200],
              blurRadius: 32,
              offset: Offset(0, 5),
            ),
          ],
        ),
        child: Icon(
          Icons.add,
          size: 48,
          color: white,
        ),
      ),
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

class TodoListTiles extends StatefulWidget {
  TodoListTiles({Key key}) : super(key: key);

  @override
  _TodoListTilesState createState() => _TodoListTilesState();
}

class _TodoListTilesState extends State<TodoListTiles> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 28),
      child: ListView.builder(
        physics: BouncingScrollPhysics(),
        itemCount: 10,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return TodoListTile();
        },
      ),
    );
  }
}
