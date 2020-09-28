import 'package:flutter/material.dart';
import 'theme.dart';

customerAppBar() {
  return PreferredSize(
    preferredSize: Size.fromHeight(5.0), // here the desired height
    child: AppBar(
      backgroundColor: white,
      elevation: 0,
    ),
  );
}

String tickAssetPath = 'assets/tick.png';