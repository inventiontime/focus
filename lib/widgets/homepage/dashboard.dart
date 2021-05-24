import 'package:flutter/material.dart';
import 'package:focus/data.dart';
import 'package:focus/data/appdata.dart';
import 'package:focus/data/storage.dart';
import 'package:focus/widgets/components.dart';
import 'package:focus/modifiers.dart';
import 'package:focus/data/types.dart';
import 'dashboardwidgets/heatmap.dart';
import 'dashboardwidgets/tagstats.dart';
import 'dashboardwidgets/daystats.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int page = 0;
  int timeOffset = 0;
  List<Widget> get pages => [
        DayStats(),
        TagStats(timeOffset),
        Heatmap(),
      ];

  void next() {
    if (page < pages.length - 1)
      setState(() {
        page++;
      });
  }

  void previous() {
    if (page > 0)
      setState(() {
        page--;
      });
  }

  @override
  Widget build(BuildContext context) {
    return BackgroundBox(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextButton(
              child: Icon(Icons.arrow_back_ios_outlined, color: green),
              onPressed: previous),
          pages[page].padding(30).expanded(),
          TextButton(
              child: Icon(Icons.arrow_forward_ios_outlined, color: green),
              onPressed: next),
        ],
      ),
    );
  }
}
