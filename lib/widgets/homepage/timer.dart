import 'package:flutter/material.dart';
import 'package:focus/data.dart';
import 'package:focus/data/storage.dart';
import 'package:focus/modifiers.dart';
import 'package:focus/widgets/components.dart';
import 'package:focus/data/appdata.dart';

class Timer extends StatefulWidget {
  @override
  _TimerState createState() => _TimerState();
}

class _TimerState extends State<Timer> {
  void _plusPressed(bool _workTimeSelected, bool quadruple) {
    setState(() {
      if (_workTimeSelected) {
        if (quadruple)
          appData.preferences.workTime += 20;
        else
          appData.preferences.workTime += 5;
      } else {
        if (quadruple)
          appData.preferences.breakTime += 5;
        else
          appData.preferences.breakTime += 1;
      }
    });
  }

  void _minusPressed(bool _workTimeSelected, bool quadruple) {
    setState(() {
      if (_workTimeSelected) {
        if (quadruple)
          appData.preferences.workTime -= 20;
        else
          appData.preferences.workTime -= 5;
      } else {
        if (quadruple)
          appData.preferences.breakTime -= 5;
        else
          appData.preferences.breakTime -= 1;
      }
      if (appData.preferences.workTime < 5) appData.preferences.workTime = 5;
      if (appData.preferences.breakTime < 1) appData.preferences.breakTime = 1;
    });
  }

  void _continue() {
    appData.setNumber = 1;
    Navigator.pushNamed(context, 'worktimer');
    Storage.storage.writePreferences();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FractionallySizedBox(
          widthFactor: 0.9,
          heightFactor: 0.8,
          child: LayoutBuilder(builder: (context, constraints) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(children: [
                  BackgroundBox(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text('work time',
                              style: Theme.of(context).textTheme.bodyText1),
                          RowText(
                              appData.preferences.workTime.toString(), 'min',
                              style1: Theme.of(context)
                                  .textTheme
                                  .headline2
                                  .copyWith(color: red),
                              style2: Theme.of(context)
                                  .textTheme
                                  .bodyText1
                                  .copyWith(color: red)),
                          Divider(indent: 30, endIndent: 30),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              TextButton(
                                  child: Icon(Icons.first_page,
                                      color: violet,
                                      size: constraints.maxHeight * 0.1),
                                  onPressed: () {
                                    _minusPressed(true, true);
                                  }),
                              TextButton(
                                  child: Icon(Icons.remove,
                                      color: violet,
                                      size: constraints.maxHeight * 0.1),
                                  onPressed: () {
                                    _minusPressed(true, false);
                                  }),
                              TextButton(
                                  child: Icon(Icons.add,
                                      color: violet,
                                      size: constraints.maxHeight * 0.1),
                                  onPressed: () {
                                    _plusPressed(true, false);
                                  }),
                              TextButton(
                                  child: Icon(Icons.last_page,
                                      color: violet,
                                      size: constraints.maxHeight * 0.1),
                                  onPressed: () {
                                    _plusPressed(true, true);
                                  }),
                            ],
                          )
                        ]),
                  ).expanded(),
                  SizedBox(width: 30),
                  BackgroundBox(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text('break time',
                              style: Theme.of(context).textTheme.bodyText1),
                          RowText(
                              appData.preferences.breakTime.toString(), 'min',
                              style1: Theme.of(context)
                                  .textTheme
                                  .headline2
                                  .copyWith(color: blue),
                              style2: Theme.of(context)
                                  .textTheme
                                  .bodyText1
                                  .copyWith(color: blue)),
                          Divider(indent: 30, endIndent: 30),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              TextButton(
                                  child: Icon(Icons.first_page,
                                      color: violet,
                                      size: constraints.maxHeight * 0.1),
                                  onPressed: () {
                                    _minusPressed(false, true);
                                  }),
                              TextButton(
                                  child: Icon(Icons.remove,
                                      color: violet,
                                      size: constraints.maxHeight * 0.1),
                                  onPressed: () {
                                    _minusPressed(false, false);
                                  }),
                              TextButton(
                                  child: Icon(Icons.add,
                                      color: violet,
                                      size: constraints.maxHeight * 0.1),
                                  onPressed: () {
                                    _plusPressed(false, false);
                                  }),
                              TextButton(
                                  child: Icon(Icons.last_page,
                                      color: violet,
                                      size: constraints.maxHeight * 0.1),
                                  onPressed: () {
                                    _plusPressed(false, true);
                                  }),
                            ],
                          )
                        ]),
                  ).expanded(),
                ]).expanded(),
                SizedBox(height: 30),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: backgroundColor3,
                  ),
                  height: constraints.maxHeight * 0.1 * 1.5,
                  child: TextButton(
                      child: Icon(Icons.done,
                          size: constraints.maxHeight * 0.1, color: green),
                      onPressed: _continue),
                ),
              ],
            );
          })),
    );
  }
}
