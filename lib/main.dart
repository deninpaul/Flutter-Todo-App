import 'package:flutter/material.dart';
import 'package:todo/UI/Utils/theme.dart';
import 'package:todo/UI/home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Home(),
      theme: ThemeData(fontFamily: primaryFont, primaryColor: blue),
    );
  }
}
