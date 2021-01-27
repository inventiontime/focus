import 'package:flutter/material.dart';

Color backgroundColor = Color(0xFF050509);
Color backgroundColor2 = Color(0xFF111119);
Color backgroundColor3 = Color(0xFF222229);
Color foregroundColor = Colors.white;

Color red = Color(0xFFff584d);
Color orange = Color(0xFFffa94d);
Color yellow = Color(0xFFfff64d);
Color green = Color(0xFF9bff70);
Color blue = Color(0xFF70c4ff);
Color violet = Color(0xFFae70ff);
Color gray = Color(0xFFaeaacc);

List<String> alarms = ['Daybreak', 'Early Riser', 'Slow Morning'];
List<String> alarmPaths = ['assets/audio/Daybreak.mp3', 'assets/audio/EarlyRiser.mp3', 'assets/audio/SlowMorning.mp3'];

ThemeData theme = ThemeData(
  fontFamily: 'Euclid',
  colorScheme: ColorScheme.dark(),
  textTheme: TextTheme(
    headline1: TextStyle(fontSize: 35.0, fontWeight: FontWeight.bold, color: foregroundColor),
    headline2: TextStyle(fontSize: 40.0, fontWeight: FontWeight.bold, color: foregroundColor),
    headline3: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold, color: foregroundColor),
    bodyText1: TextStyle(fontSize: 25.0, color: foregroundColor),
    bodyText2: TextStyle(fontSize: 15.0, color: foregroundColor),
    subtitle1: TextStyle(fontSize: 10.0, color: foregroundColor),
  )
);