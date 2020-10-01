import 'package:DSCtodo/UI/Utils/theme.dart';
import 'package:flutter/material.dart';
import 'UI/home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: primaryFont,
        primaryColor: blue,
      ),
      home: Home(),
    );
  }
}
