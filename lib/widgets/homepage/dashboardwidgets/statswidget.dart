import 'package:flutter/material.dart';
import 'package:focus/data.dart';
import 'package:focus/widgets/components.dart';

class StatsWidget extends StatelessWidget {
  @override
  StatsWidget({this.time, this.productivity});
  int productivity;
  int time;

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
              (time == null) ? '--' : (time / 60).toStringAsFixed(1),
              'hr',
              style1:
                  Theme.of(context).textTheme.headline2.copyWith(color: red),
              style2:
                  Theme.of(context).textTheme.bodyText1.copyWith(color: red),
            ),
            Text('of work', style: Theme.of(context).textTheme.bodyText1),
          ],
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RowText(
                (productivity == null) ? '--' : productivity.toString(), '%',
                style1:
                    Theme.of(context).textTheme.headline2.copyWith(color: blue),
                style2: Theme.of(context)
                    .textTheme
                    .bodyText1
                    .copyWith(color: blue)),
            Text('productivity', style: Theme.of(context).textTheme.bodyText1),
          ],
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RowText(
                (time == null || productivity == null)
                    ? '--'
                    : ((time / 60) * productivity / 100).toStringAsFixed(1),
                'hr',
                style1: Theme.of(context)
                    .textTheme
                    .headline2
                    .copyWith(color: violet),
                style2: Theme.of(context)
                    .textTheme
                    .bodyText1
                    .copyWith(color: violet)),
            Text('productive work',
                style: Theme.of(context).textTheme.bodyText1),
          ],
        ),
      ],
    );
  }
}
