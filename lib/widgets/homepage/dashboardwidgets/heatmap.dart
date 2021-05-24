import 'package:flutter/material.dart';
import 'package:focus/data.dart';
import 'package:focus/data/appdata.dart';
import 'package:focus/modifiers.dart';
import 'package:focus/widgets/homepage/dashboardwidgets/heatmapwidget.dart';
import 'package:focus/functions.dart' as functions;
import 'package:heatmap_calendar/time_utils.dart';

import 'headings.dart';

class Heatmap extends StatefulWidget {
  @override
  _HeatmapState createState() => _HeatmapState();
}

class _HeatmapState extends State<Heatmap> {
  Map<DateTime, int> workTime = {};
  Map<DateTime, int> productivity = {};
  Map<DateTime, int> productiveTime = {};

  @override
  void initState() {
    super.initState();

    getTime();
    getProductivity();
  }

  void getTime() async {
    int time = 0;
    int day = 0;
    int i = appData.sessions.length - 1;
    while (day < 356) {
      for (; i >= 0; i--) {
        if (appData.sessions[i].day < functions.day() - day)
          break;
        else
          time += appData.sessions[i].time;
      }
      workTime[TimeUtils.removeTime(
          DateTime.now().subtract(Duration(days: day)))] = (time / 6).round();
      setState(() {
        getProductiveTime(day);
      });
      time = 0;
      day++;
    }
  }

  void getProductivity() async {
    int prod = 0;
    int index = 0;
    int day = 0;
    int i = appData.sessions.length - 1;
    while (day < 356) {
      for (; i >= 0; i--) {
        if (appData.sessions[i].day < functions.day() - day)
          break;
        else if (appData.sessions[i].details) {
          prod += appData.sessions[i].productivity;
          index++;
        }
      }
      productivity[TimeUtils.removeTime(
              DateTime.now().subtract(Duration(days: day)))] =
          (index > 0 ? (prod / index).round() : 0);
      setState(() {
        getProductiveTime(day);
      });
      prod = 0;
      index = 0;
      day++;
    }
  }

  void getProductiveTime(int day) {
    int time = workTime[
        TimeUtils.removeTime(DateTime.now().subtract(Duration(days: day)))];
    int prod = productivity[
        TimeUtils.removeTime(DateTime.now().subtract(Duration(days: day)))];
    productiveTime[TimeUtils.removeTime(
            DateTime.now().subtract(Duration(days: day)))] =
        (prod != null && time != null ? (time * prod / 100).round() : 0);
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      StatsHeading(
        name: "Heatmaps",
        child: Text("double click to see date",
            style: Theme.of(context).textTheme.bodyText2),
      ),
      SizedBox(height: 40),
      Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text("work time", style: Theme.of(context).textTheme.bodyText1)
                .padding(30),
            HeatmapWidget(
              input: workTime,
              colorThresholds: {
                1: red.withOpacity(0.05),
                for (int i = 5; i <= 120; i += 5)
                  i: red.withOpacity((i / 120 > 1 ? 1 : i / 120)),
              },
              labelTextColor: foregroundColor,
            ),
            Divider(indent: 30, endIndent: 30),
            Text("productivity", style: Theme.of(context).textTheme.bodyText1)
                .padding(30),
            HeatmapWidget(
              input: productivity,
              colorThresholds: {
                1: blue.withOpacity(0.05),
                for (int i = 5; i <= 100; i += 5)
                  i: blue.withOpacity(
                      (i - 40) / (100 - 40) < 0 ? 0 : (i - 40) / (100 - 40)),
              },
              labelTextColor: foregroundColor,
            ),
            Divider(indent: 30, endIndent: 30),
            Text("productive time",
                    style: Theme.of(context).textTheme.bodyText1)
                .padding(30),
            HeatmapWidget(
              input: productiveTime,
              colorThresholds: {
                1: violet.withOpacity(0.05),
                for (int i = 5; i <= 120; i += 5)
                  i: violet.withOpacity((i / 120 > 1 ? 1 : i / 120)),
              },
              labelTextColor: foregroundColor,
            ),
          ],
        ).scrollable(),
      ).expanded(),
    ]);
  }
}
