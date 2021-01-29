import 'package:flutter/material.dart';
import 'package:focus/data.dart';
import 'package:focus/modifiers.dart';
import 'package:focus/widgets/components.dart';
import 'package:focus/data/appdata.dart';

class Timer extends StatefulWidget {
  @override
  _TimerState createState() => _TimerState();
}

class _TimerState extends State<Timer> {
  void _plusPressed(bool _workTimeSelected) {
    setState(() {
      if(_workTimeSelected) appData.preferences.workTime += 5;
      else appData.preferences.breakTime += 1;
    });
  }

  void _minusPressed(bool _workTimeSelected) {
    setState(() {
      if(_workTimeSelected) {
        appData.preferences.workTime -= 5;
        if(appData.preferences.workTime < 5) appData.preferences.workTime = 5;
      }
      else {
        appData.preferences.breakTime -= 1;
        if(appData.preferences.breakTime < 1) appData.preferences.breakTime = 1;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FractionallySizedBox(
        widthFactor: 0.9,
        heightFactor: 0.8,
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  children: [
                    BackgroundBox(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text('work time', style: Theme.of(context).textTheme.bodyText1),
                          RowText(appData.preferences.workTime.toString(), 'min', style1: Theme.of(context).textTheme.headline2.copyWith(color: red), style2: Theme.of(context).textTheme.bodyText1.copyWith(color: red)),
                          Divider(indent: 30, endIndent: 30),
                          Row (
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              TextButton(child: Icon(Icons.add, color: violet, size: constraints.maxHeight * 0.1), onPressed: (){_plusPressed(true);}),
                              TextButton(child: Icon(Icons.remove, color: violet, size: constraints.maxHeight * 0.1), onPressed: (){_minusPressed(true);}),
                            ],
                          )
                        ]
                      ),
                    ).expanded(),
                    SizedBox(width: 30),
                    BackgroundBox(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text('break time', style: Theme.of(context).textTheme.bodyText1),
                          RowText(appData.preferences.breakTime.toString(), 'min', style1: Theme.of(context).textTheme.headline2.copyWith(color: blue), style2: Theme.of(context).textTheme.bodyText1.copyWith(color: blue)),
                          Divider(indent: 30, endIndent: 30),
                          Row (
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              TextButton(child: Icon(Icons.add, color: violet, size: constraints.maxHeight * 0.1), onPressed: (){_plusPressed(false);}),
                              TextButton(child: Icon(Icons.remove, color: violet, size: constraints.maxHeight * 0.1), onPressed: (){_minusPressed(false);}),
                            ],
                          )
                        ]
                      ),
                    ).expanded(),
                  ]
                ).expanded(),
                SizedBox(height: 30),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: backgroundColor3,
                  ),
                  height: constraints.maxHeight * 0.1 * 1.5,
                  child: TextButton(child: Icon(Icons.done, size: constraints.maxHeight * 0.1, color: green), onPressed: (){Navigator.pushNamed(context, 'worktimer');}),
                ),
              ],
            );
          }
        )
      ),
    );
  }
}

/*
import 'package:flutter/material.dart';
import 'package:focus/data.dart';
import 'package:focus/modifiers.dart';
import 'package:focus/widgets/components.dart';
import 'package:focus/appdata.dart';

class Timer extends StatefulWidget {
  @override
  _TimerState createState() => _TimerState();
}

class _TimerState extends State<Timer> {
  bool _workTimeSelected = true;

  void _plusPressed() {
    setState(() {
      if(_workTimeSelected) appData.workTime += 5;
      else appData.breakTime += 1;
    });
  }

  void _minusPressed() {
    setState(() {
      if(_workTimeSelected) {
        appData.workTime -= 5;
        if(appData.workTime < 5) appData.workTime = 5;
      }
      else {
        appData.breakTime -= 1;
        if(appData.breakTime < 1) appData.breakTime = 1;
      }
    });
  }

  void _selectWorkTime() {
    setState(() {
      _workTimeSelected = true;
    });
  }

  void _selectBreakTime() {
    setState(() {
      _workTimeSelected = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FractionallySizedBox(
        widthFactor: 0.9,
        heightFactor: 0.8,
        child: Row(
          children: [
            BackgroundBox(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text('work time', style: Theme.of(context).textTheme.bodyText1),
                      SelectedBox(
                        selected: _workTimeSelected,
                        child: TextButton(
                          child: RowText(appData.workTime.toString(), 'min', style1: Theme.of(context).textTheme.headline2, style2: Theme.of(context).textTheme.bodyText1),
                          onPressed: _selectWorkTime,
                        ),
                      ),
                    ]
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text('break time', style: Theme.of(context).textTheme.bodyText1),
                      SelectedBox(
                        selected: !_workTimeSelected,
                        child: TextButton(
                          child: RowText(appData.breakTime.toString(), 'min', style1: Theme.of(context).textTheme.headline2, style2: Theme.of(context).textTheme.bodyText1),
                          onPressed: _selectBreakTime,
                        ),
                      ),
                    ]
                  ),
                ]
              ).scrollable().padding(40),
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      TextButton(child: Icon(Icons.add_circle, color: red, size: 75), onPressed: _plusPressed),
                      TextButton(child: Icon(Icons.remove_circle, color: red, size: 75), onPressed: _minusPressed),
                    ]
                  ),
                  TextButton(child: Icon(Icons.alarm_on_outlined, size: 100, color: green), onPressed: (){Navigator.pushNamed(context, 'worktimer');}),
                ],
              ),
            ).expanded(),
          ]
        ),
      ),
    );
  }
}
*/