import 'package:flutter/material.dart';
import 'package:focus/data.dart';
import 'package:focus/data/appdata.dart';
import 'package:focus/functions.dart';
import 'package:focus/widgets/components.dart';

class DayStats extends StatefulWidget {
  @override
  _DayStatsState createState() => _DayStatsState();
}

class _DayStatsState extends State<DayStats> {
  int time;
  int productivity;

  @override
  void initState() {
    super.initState();

    getDayTime();
    getProductivity();
  }

  static int dayTime(int day) {
    int time = 0;
    for(int i = appData.sessions.length-1; i >= 0; i--) {
      if(appData.sessions[i].day != day)
        break;

      time += appData.sessions[i].time;
    }
    return time;
  }

  void getDayTime() {
    setState((){ time = dayTime(day()); });
  }

  static int dayProductivity(int day) {
    int productivity = 0;
    int index = 0;
    for(int i = appData.sessions.length-1; i >= 0; i--) {
      if(appData.sessions[i].day != day)
        break;

      if(appData.sessions[i].details) {
        productivity += appData.sessions[i].productivity;
        index ++;
      }
    }
    return (index != 0) ? (productivity/index).round() : 0;
  }

  void getProductivity() {
    setState((){ productivity = dayProductivity(day()); });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RowText(
                (time == null) ? '--' : (time / 60).toStringAsFixed(1), 'hr',
                style1: Theme.of(context).textTheme.headline2.copyWith(color: red),
                style2: Theme.of(context).textTheme.bodyText1.copyWith(color: red),
            ),
            Text('of work', style: Theme.of(context).textTheme.bodyText1),
          ],
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RowText(
                (productivity == null) ? '--' : productivity.toString(), '%',
                style1: Theme.of(context).textTheme.headline2.copyWith(color: blue),
                style2: Theme.of(context).textTheme.bodyText1.copyWith(color: blue)
            ),
            Text('productivity', style: Theme.of(context).textTheme.bodyText1),
          ],
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RowText(
                (time == null || productivity == null) ? '--' : ((time / 60) * productivity / 100).toStringAsFixed(1), 'hr',
                style1: Theme.of(context).textTheme.headline2.copyWith(color: violet),
                style2: Theme.of(context).textTheme.bodyText1.copyWith(color: violet)
            ),
            Text('productive work', style: Theme.of(context).textTheme.bodyText1),
          ],
        ),
      ],
    );
  }
}
