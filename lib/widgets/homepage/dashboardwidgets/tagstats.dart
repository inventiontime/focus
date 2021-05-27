import 'package:flutter/material.dart';
import 'package:focus/data/appdata.dart';
import 'package:focus/functions.dart' as functions;
import 'package:focus/modifiers.dart';
import 'package:focus/widgets/homepage/dashboardwidgets/headings.dart';
import 'package:focus/widgets/homepage/dashboardwidgets/statswidget.dart';
import 'package:focus/widgets/modulewidgets.dart';

class TagStats extends StatefulWidget {
  TagStats({Key key}) : super(key: key);

  @override
  _TagStatsState createState() => _TagStatsState();
}

class _TagStatsState extends State<TagStats> {
  int time;
  int productivity;
  int day;
  int tagId = appData.tags[0].id;

  @override
  void initState() {
    super.initState();
    getDayStats(functions.day());
  }

  int tagTime() {
    if (tagId == null) return null;

    int time = 0;
    for (int i = appData.sessions.length - 1; i >= 0; i--) {
      if (appData.sessions[i].day < day)
        break;
      else if (appData.sessions[i].day == day) if (appData.sessions[i].tagId ==
          tagId) time += appData.sessions[i].time;
    }
    return time;
  }

  int tagProductivity() {
    if (tagId == null) return null;

    int productivity = 0;
    int index = 0;
    for (int i = appData.sessions.length - 1; i >= 0; i--) {
      if (appData.sessions[i].day < day)
        break;
      else if (appData.sessions[i].day == day) if (appData
          .sessions[i].details) if (appData.sessions[i].tagId == tagId) {
        productivity += appData.sessions[i].productivity;
        index++;
      }
    }
    return (index != 0) ? (productivity / index).round() : 0;
  }

  void getDayStats(int day) {
    setState(() {
      this.day = day;
      time = tagTime();
      productivity = tagProductivity();
    });
  }

  void getTagStats(int tagId) {
    setState(() {
      this.tagId = tagId;
      time = tagTime();
      productivity = tagProductivity();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      StatsHeading(
        name: "Tag Stats",
        child: ChooseDay(onPressed: (int day) {
          getDayStats(day);
        }),
      ),
      SizedBox(height: 40),
      StatsWidget(time: time, productivity: productivity).expanded(),
      Divider(indent: 30, endIndent: 30),
      ChooseTag(onSelected: getTagStats).padding(30),
    ]);
  }
}
