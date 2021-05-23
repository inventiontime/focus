import 'package:flutter/material.dart';
import 'package:focus/data.dart';
import 'package:focus/functions.dart';
import 'package:focus/modifiers.dart';
import 'package:intl/intl.dart';

class StatsHeading extends StatelessWidget {
  @override
  StatsHeading({this.name, this.child});
  String name;
  Widget child;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(name, style: Theme.of(context).textTheme.headline3),
        SizedBox().expanded(),
        child,
      ],
    );
  }
}

class ChooseDay extends StatefulWidget {
  @override
  ChooseDay({this.onPressed});
  final void Function(int day) onPressed;

  @override
  _ChooseDayState createState() => _ChooseDayState();
}

class _ChooseDayState extends State<ChooseDay> {
  int dayVal = day();

  void nextTime() {
    if (dayVal < day())
      setState(() {
        dayVal++;
        widget.onPressed(dayVal);
      });
  }

  void previousTime() {
    setState(() {
      dayVal--;
      widget.onPressed(dayVal);
    });
  }

  void setDate(context) async {
    DateTime date = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1),
        lastDate: DateTime.now());
    if (date != null)
      setState(() {
        dayVal = -DateTime(1).difference(date).inDays;
        widget.onPressed(dayVal);
      });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        TextButton(
            child: Icon(Icons.arrow_back_ios_outlined, color: orange),
            onPressed: previousTime),
        Container(
            width: 75,
            alignment: Alignment.center,
            child: TextButton(
              child: Text(DateFormat('LLL d').format(getDateFromDay(dayVal)),
                  style: Theme.of(context).textTheme.bodyText2),
              onPressed: () {
                setDate(context);
              },
            )),
        TextButton(
            child: Icon(Icons.arrow_forward_ios_outlined, color: orange),
            onPressed: nextTime),
      ],
    );
  }
}
