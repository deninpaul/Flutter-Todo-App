import 'package:flutter/material.dart';
import 'package:todo/Services/database.dart';
import 'package:todo/UI/Components/newDialog.dart';
import 'package:todo/UI/Utils/global.dart';
import 'package:todo/UI/Utils/theme.dart';
import 'Components/todoListTile.dart';

class Home extends StatelessWidget {
  final GlobalKey<_TodoEntryListState> _myWidgetState =
      GlobalKey<_TodoEntryListState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customerAppBar(),
      body: CustomScrollView(
        physics: BouncingScrollPhysics(),
        slivers: <Widget>[
          SliverAppBar(
            expandedHeight: 120.0,
            floating: true,
            pinned: true,
            backgroundColor: white,
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              title: Text(
                "todolist",
                style: TextStyle(
                    color: blue,
                    fontWeight: FontWeight.bold,
                    fontFamily: primaryFont),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return TodoEntryList(
                  key: _myWidgetState,
                );
              },
              childCount: 1,
            ),
          )
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: customFAB(context),
    );
  }

  customFAB(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(8),
      child: RaisedButton(
        onPressed: () => newTodoDialog(context),
        shape: CircleBorder(),
        elevation: 3,
        color: blue,
        child: Container(
          padding: EdgeInsets.all(10),
          child: Icon(
            Icons.add,
            size: 48,
            color: white,
          ),
        ),
      ),
    );
  }

  newTodoDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return NewTodoForm(
          listUpdator: () => _myWidgetState.currentState.listUpdator(),
        );
      },
    );
  }
}

class TodoEntryList extends StatefulWidget {
  TodoEntryList({Key key}) : super(key: key);

  @override
  _TodoEntryListState createState() => _TodoEntryListState();
}

class _TodoEntryListState extends State<TodoEntryList> {
  List<Widget> list;
  var db = DBProvider.db;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder(
        future: db.getAllTodoEntries(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              children: [
                SizedBox(
                  height: 24,
                ),
                ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  reverse: true,
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) {
                    return TodoListTile(
                      entry: snapshot.data[index],
                      listUpdator: () => listUpdator(),
                    );
                  },
                ),
                SizedBox(
                  height: 140,
                ),
              ],
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  listUpdator() {
    setState(() {
      db.getAllTodoEntries();
    });
  }
}
