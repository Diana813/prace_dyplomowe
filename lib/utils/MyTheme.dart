import 'package:flutter/material.dart';

import 'MyColors.dart';

final ThemeData MyThemeData = ThemeData(
    textTheme: const TextTheme(
      headline1: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
      headline6: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
      bodyText2: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
    ),
    brightness: Brightness.light,
    primaryColorBrightness: Brightness.light,
    primaryColor: MyColors.orange[900],
    elevatedButtonTheme: MyButtonThemeData,
    appBarTheme: AppBarTheme(color: MyColors.orange),
    floatingActionButtonTheme:
        FloatingActionButtonThemeData(backgroundColor: MyColors.orange));

final ElevatedButtonThemeData MyButtonThemeData =
    ElevatedButtonThemeData(style: ButtonStyle(
  backgroundColor: MaterialStateProperty.resolveWith<Color?>(
    (Set<MaterialState> states) {
      if (states.contains(MaterialState.pressed)) return MyColors.green[100];
      return MyColors.green[400]; // Use the component's default.
    },
  ),
      padding: MaterialStateProperty.resolveWith<EdgeInsetsGeometry?>(
            (Set<MaterialState> states) {
          if (states.contains(MaterialState.pressed)) return EdgeInsets.all(10);
          return EdgeInsets.all(15); // Use the component's default.
        },
      ),
      fixedSize: MaterialStateProperty.resolveWith<Size?>(
            (Set<MaterialState> states) {
          if (states.contains(MaterialState.pressed)) return Size(150, 40);
          return Size(150, 40); // Use the component's default.
        },
      ),
));
