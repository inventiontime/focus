import 'package:flutter/foundation.dart' as Foundation;
import 'package:flutter/material.dart';
import 'package:focus/data/appdata.dart';
import 'package:focus/audio.dart';
import 'package:focus/data.dart';
import 'package:focus/data/storage.dart';
import 'package:focus/data/types.dart';
import 'package:focus/enum.dart';
import 'package:focus/widgets/timerscreen/ring.dart';
import 'package:focus/modifiers.dart';

class WorkTimer extends StatefulWidget {
  @override
  _WorkTimerState createState() => _WorkTimerState();
}

class _WorkTimerState extends State<WorkTimer> with TickerProviderStateMixin {
  AnimationController controller;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
        vsync: this,
        duration: (Foundation.kReleaseMode
            ? Duration(minutes: appData.preferences[Preference.workTime.index])
            : Duration(seconds: appData.preferences[Preference.workTime.index])),
        reverseDuration: Duration(seconds: 1));

    controller.reverse(from: 1);

    controller.reverse().whenComplete(() => {
          controller.forward(from: 0),
          controller.forward().whenComplete(() => {
                Storage.storage.addSession(appData.preferences[Preference.workTime.index]),
                audio.playWorkAlarm(),
                Navigator.pushNamed(context, 'breaktimer'),
              })
        });
  }

  void popupFunction(TimerScreenOptions result) {
    switch (result) {
      case TimerScreenOptions.skip:
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('The last work session has not been counted',
              style: Theme.of(context)
                  .textTheme
                  .bodyText2
                  .copyWith(color: foregroundColor)),
          backgroundColor: backgroundColor,
        ));
        audio.stopAlarm();
        Navigator.pushNamed(context, 'breaktimer');
        break;

      case TimerScreenOptions.exit:
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('The last work session has not been counted',
              style: Theme.of(context)
                  .textTheme
                  .bodyText2
                  .copyWith(color: foregroundColor)),
          backgroundColor: backgroundColor,
        ));
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
                title: Text('Skip to break'),
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
        Ring(controller: controller, color: red),
        Center(
          child: Text(appData.setNumber.toString(),
              style:
                  Theme.of(context).textTheme.headline2.copyWith(color: red)),
        ),
      ]).padding(40),
    );
  }
}
