import 'package:flutter/material.dart';
import 'package:focus/data/appdata.dart';
import 'package:focus/audio.dart';
import 'package:focus/data.dart';
import 'package:focus/data/storage.dart';
import 'package:focus/enum.dart';
import 'package:focus/widgets/timerscreen/ring.dart';
import 'package:focus/modifiers.dart';

class BreakTimer extends StatefulWidget {
  @override
  _BreakTimerState createState() => _BreakTimerState();
}

class _BreakTimerState extends State<BreakTimer> with TickerProviderStateMixin {
  AnimationController controller;
  double _currentSliderValue = 80;
  int _value;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
        vsync: this,
        //TODO: change to minutes
        duration: Duration(seconds: appData.preferences.breakTime),
        reverseDuration: Duration(seconds: 1)
    );

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
    if(_value != null) Storage.storage.addSessionDetails(_value, _currentSliderValue.round());
  }

  void popupFunction(TimerScreenOptions result) {
    onBreakComplete();

    switch(result) {
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
      body: Stack(
        children: [
          PopupMenuButton <TimerScreenOptions>(
            onSelected: (TimerScreenOptions result){popupFunction(result);},
            itemBuilder: (BuildContext context) => <PopupMenuEntry<TimerScreenOptions>>[
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
              Column (
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('productivity', style: Theme.of(context).textTheme.headline3),
                  SizedBox(height: 20),
                  Slider(
                    value: _currentSliderValue,
                    min: 30,
                    max: 100,
                    divisions: 7,
                    label: _currentSliderValue.round().toString(),
                    onChanged: (double value) {
                      setState(() { _currentSliderValue = value; });
                    },
                  ),
                  SizedBox(height: 50),
                  Text('tags', style: Theme.of(context).textTheme.headline3),
                  SizedBox(height: 20),
                  Wrap(
                    spacing: 10,
                    runSpacing: 15,
                    children: List<Widget>.generate(appData.tags.length,
                      (int index) {
                        return ChoiceChip(
                          selectedColor: red,
                          label: Text(appData.tags[index].name),
                          labelStyle: Theme.of(context).textTheme.bodyText2,
                          padding: EdgeInsets.all(10),
                          selected: _value == index,
                          onSelected: (bool selected) {
                            setState(() {
                              _value = selected ? index : null;
                            });
                          },
                        );
                      },
                    ).toList(),
                  ),
                ],
              ).padding(40).scrollable().expanded(),
              Stack (
                children: [
                  Ring(controller: controller, color: blue),
                  Center(
                    child: Text(appData.setNumber.toString(), style: Theme.of(context).textTheme.headline2.copyWith(color: blue)),
                  ),
                ]
              ).expanded(),
            ]
          ),
        ]
      ).padding(40),
    );
  }
}