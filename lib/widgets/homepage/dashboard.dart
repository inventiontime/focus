import 'package:flutter/material.dart';
import 'package:focus/data.dart';
import 'package:focus/widgets/components.dart';
import 'package:focus/modifiers.dart';
import 'package:focus/widgets/homepage/dashboardwidgets/daychart.dart';
import 'package:focus/widgets/homepage/dashboardwidgets/sessionslist.dart';
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
        DayStats(key: ValueKey(1)),
        TagStats(key: ValueKey(2)),
        DayChart(key: ValueKey(5)),
        Heatmap(key: ValueKey(3)),
        SessionList(key: ValueKey(4)),
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
          AnimatedSwitcher(
                  duration: const Duration(milliseconds: 250),
                  child: pages[page])
              .padding(30)
              .expanded(),
          TextButton(
              child: Icon(Icons.arrow_forward_ios_outlined, color: green),
              onPressed: next),
        ],
      ),
    );
  }
}
