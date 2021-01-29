import 'package:flutter/material.dart';
import 'package:focus/data.dart';
import 'package:focus/widgets/components.dart';
import 'package:focus/modifiers.dart';
import 'package:focus/widgets/homepage/dashboardpages/daystats.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final int noOfPages = 1;
  int page = 0;

  void next() {
    if(page < noOfPages-1)
      setState(() { page++; });
  }

  void previous() {
    if(page > 0)
      setState(() { page--; });
  }

  @override
  Widget build(BuildContext context) {
    return BackgroundBox(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextButton(child: Icon(Icons.chevron_left_outlined, color: green), onPressed: (){}),
          [
            DayStats(),
          ][page].expanded(),
          TextButton(child: Icon(Icons.chevron_right_outlined, color: green), onPressed: (){}),
        ],
      ),
    );
  }
}