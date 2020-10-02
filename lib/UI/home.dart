import 'package:DSCtodo/Data/todoListClass.dart';
import 'package:DSCtodo/Services/localDatabase.dart';
import 'package:DSCtodo/UI/Components/newTodoDialog.dart';
import 'package:DSCtodo/UI/Components/todoListTile.dart';
import 'package:flutter/material.dart';
import 'Utils/theme.dart';

class Home extends StatelessWidget {
  Home({Key key}) : super(key: key);

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
      floatingActionButton: customFAB(context),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  customFAB(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return NewTodoDialog();
            });
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
  var db = DBProvider.db;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 28),
      child: FutureBuilder(
        future: db.getAllTodoEntries(),
        builder:
            (BuildContext context, AsyncSnapshot<List<TodoEntry>> snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              physics: BouncingScrollPhysics(),
              itemCount: snapshot.data.length,
              shrinkWrap: true,
              reverse: true,
              itemBuilder: (context, index) {
                return TodoListTile(
                  entry: snapshot.data[index],
                );
              },
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
