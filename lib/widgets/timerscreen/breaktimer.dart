import 'package:flutter/foundation.dart' as Foundation;
import 'package:flutter/material.dart';
import 'package:focus/data/appdata.dart';
import 'package:focus/audio.dart';
import 'package:focus/data.dart';
import 'package:focus/data/storage.dart';
import 'package:focus/data/types.dart';
import 'package:focus/enum.dart';
import 'package:focus/widgets/modulewidgets.dart';
import 'package:focus/widgets/timerscreen/ring.dart';
import 'package:focus/modifiers.dart';

class BreakTimer extends StatefulWidget {
  @override
  _BreakTimerState createState() => _BreakTimerState();
}

class _BreakTimerState extends State<BreakTimer> with TickerProviderStateMixin {
  AnimationController controller;
  int productivityValue = 80;
  int _value = appData.tags[0].id;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
        vsync: this,
        duration: (Foundation.kReleaseMode
            ? Duration(minutes: appData.preferences[Preference.breakTime.index])
            : Duration(
                seconds: appData.preferences[Preference.breakTime.index])),
        reverseDuration: Duration(seconds: 1));

    controller.reverse(from: 1);

    controller.reverse().whenComplete(() => {
          controller.forward(from: 0),
          controller.forward().whenComplete(() => {
                onBreakComplete(),
                audio.playBreakAlarm(),
                Navigator.pushNamed(context, 'worktimer'),
              })
        });
  }

  void onBreakComplete() {
    appData.setNumber++;
    if (_value != null)
      Storage.storage.addSessionDetails(_value, productivityValue);
  }

  void popupFunction(TimerScreenOptions result) {
    onBreakComplete();

    switch (result) {
      case TimerScreenOptions.skip:
        audio.stopAlarm();
        Navigator.pushNamed(context, 'worktimer');
        break;

      case TimerScreenOptions.exit:
        audio.stopAlarm();
        Navigator.pushNamed(context, 'dashboard');
        break;

      default:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor2,
      body: Stack(children: [
        PopupMenuButton<TimerScreenOptions>(
          onSelected: (TimerScreenOptions result) {
            popupFunction(result);
          },
          itemBuilder: (BuildContext context) =>
              <PopupMenuEntry<TimerScreenOptions>>[
            const PopupMenuItem<TimerScreenOptions>(
              value: TimerScreenOptions.skip,
              child: ListTile(
                title: Text('Skip to work'),
                leading: Icon(Icons.skip_next_outlined),
              ),
            ),
            const PopupMenuItem<TimerScreenOptions>(
              value: TimerScreenOptions.exit,
              child: ListTile(
                title: Text('End session'),
                leading: Icon(Icons.alarm_off_outlined),
              ),
            ),
          ],
        ),
        Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ChooseProductivity(
                    onChanged: appData.sessions.last.details
                        ? null
                        : (int value) {
                            setState(() {
                              productivityValue = value;
                            });
                          },
                    startingValue: productivityValue,
                  ),
                  Divider(height: 50),
                  ChooseTag(
                    onSelected: appData.sessions.last.details
                        ? null
                        : (int tagId) {
                            setState(() {
                              _value = tagId;
                            });
                          },
                  ),
                ],
              ).padding(40).scrollable().expanded(),
              Stack(children: [
                Ring(controller: controller, color: blue),
                Center(
                  child: Text(appData.setNumber.toString(),
                      style: Theme.of(context)
                          .textTheme
                          .headline2
                          .copyWith(color: blue)),
                ),
              ]).expanded(),
            ]),
      ]).padding(40),
    );
  }
}
