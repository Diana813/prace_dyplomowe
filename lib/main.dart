
import 'package:flutter/material.dart';
import 'package:prace_dyplomowe/utils/MyTheme.dart';

import 'fragments/HomePage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Prace dyplomowe demo',
      theme: MyThemeData,
      home: MyHomePage(title: 'Prace dyplomowe demo'),
    );
  }
}

