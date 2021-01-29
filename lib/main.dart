import 'package:flutter/material.dart';
import 'package:focus/data.dart';
import 'package:focus/data/storage.dart';
import 'package:focus/enum.dart';
import 'package:focus/widgets/homepage/homepage.dart';
import 'package:focus/widgets/stopsoundoverlay.dart';
import 'package:focus/widgets/timerscreen/worktimer.dart';
import 'package:focus/widgets/timerscreen/breaktimer.dart';

void main() async {
  await Storage.storage.read();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: theme,
      home: Stack(
        children: [
          MaterialApp(
            title: 'Focus',
            initialRoute: 'dashboard',
            routes: {
              'dashboard': (context) => HomePage(HomePageType.dashboard),
              'timer': (context) => HomePage(HomePageType.timer),
              'settings': (context) => HomePage(HomePageType.settings),
              'worktimer': (context) => WorkTimer(),
              'breaktimer': (context) => BreakTimer(),
            },
            debugShowCheckedModeBanner: false,
            theme: theme,
          ),
          StopSoundOverlay(),
        ],
      ),
    );
  }
}