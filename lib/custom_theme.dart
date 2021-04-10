import 'package:flutter/material.dart';

import 'theme/color.dart';

//TODO: Implement theme switch

final darkTheme = ThemeData(
  scaffoldBackgroundColor: Colors.black,
  accentColor: Colors.red,
);

final lightTheme = ThemeData(
    scaffoldBackgroundColor: Colors.white,
    accentColor: Pallete.color3,
    primaryColor: Colors.white,
    backgroundColor: Colors.black,
    textTheme: TextTheme(
      bodyText2: TextStyle(fontFamily: "Orb-Regular"),
      bodyText1: TextStyle(fontFamily: "Orb-Bold"),
      subtitle1: TextStyle(
          fontFamily: "Orb-Bold", fontSize: 30, fontWeight: FontWeight.bold),
      subtitle2: TextStyle(fontFamily: "Orb-Bold"),
      headline6: TextStyle(fontFamily: "Orb-Bold"),
      headline1: TextStyle(fontFamily: "Orb-Bold"),
      headline2: TextStyle(fontFamily: "Orb-Bold"),
      headline3: TextStyle(fontFamily: "Orb-Bold"),
      headline4: TextStyle(fontFamily: "Orb-Bold"),
      headline5: TextStyle(fontFamily: "Orb-Bold"),
    ),
    dialogTheme:
        DialogTheme(titleTextStyle: TextStyle(fontFamily: "Orb-Bold")));
