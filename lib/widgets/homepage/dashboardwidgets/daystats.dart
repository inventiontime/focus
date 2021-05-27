import 'package:flutter/material.dart';
import 'package:focus/data/appdata.dart';
import 'package:focus/functions.dart' as functions;
import 'package:focus/modifiers.dart';
import 'package:focus/widgets/homepage/dashboardwidgets/headings.dart';
import 'package:focus/widgets/homepage/dashboardwidgets/statswidget.dart';

class DayStats extends StatefulWidget {
  DayStats({Key key}) : super(key: key);

  @override
  _DayStatsState createState() => _DayStatsState();
}

class _DayStatsState extends State<DayStats> {
  int time;
  int productivity;
  int day;

  @override
  void initState() {
    super.initState();
    getDayStats(functions.day());
  }

  int dayTime() {
    int time = 0;
    for (int i = appData.sessions.length - 1; i >= 0; i--) {
      if (appData.sessions[i].day < day)
        break;
      else if (appData.sessions[i].day == day) time += appData.sessions[i].time;
    }
    return time;
  }

  int dayProductivity() {
    int productivity = 0;
    int index = 0;
    for (int i = appData.sessions.length - 1; i >= 0; i--) {
      if (appData.sessions[i].day < day)
        break;
      else if (appData.sessions[i].day == day) if (appData
          .sessions[i].details) {
        productivity += appData.sessions[i].productivity;
        index++;
      }
    }
    return (index != 0) ? (productivity / index).round() : 0;
  }

  void getDayStats(int day) {
    setState(() {
      this.day = day;
      time = dayTime();
      productivity = dayProductivity();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      StatsHeading(
        name: "Day Stats",
        child: ChooseDay(onPressed: (int day) {
          getDayStats(day);
        }),
      ),
      SizedBox(height: 40),
      StatsWidget(time: time, productivity: productivity).expanded(),
    ]);
  }
}
