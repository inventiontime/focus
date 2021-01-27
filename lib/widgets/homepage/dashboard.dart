import 'package:flutter/material.dart';
import 'package:focus/data/appdata.dart';
import 'package:focus/data.dart';
import 'package:focus/widgets/components.dart';
import 'package:focus/modifiers.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return BackgroundBox(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextButton(child: Icon(Icons.chevron_left_outlined, color: green), onPressed: (){}),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RowText((appData.totalWorkTime / 60).toStringAsFixed(1), 'hr', style1: Theme.of(context).textTheme.headline2.copyWith(color: red), style2: Theme.of(context).textTheme.bodyText1.copyWith(color: red)),
                  Text('of work', style: Theme.of(context).textTheme.bodyText1),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RowText(appData.productivity.round().toString(), '%', style1: Theme.of(context).textTheme.headline2.copyWith(color: blue), style2: Theme.of(context).textTheme.bodyText1.copyWith(color: blue)),
                  Text('productivity', style: Theme.of(context).textTheme.bodyText1),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RowText(((appData.totalWorkTime / 60) * appData.productivity / 100).toStringAsFixed(1), 'hr', style1: Theme.of(context).textTheme.headline2.copyWith(color: violet), style2: Theme.of(context).textTheme.bodyText1.copyWith(color: violet)),
                  Text('productive work', style: Theme.of(context).textTheme.bodyText1),
                ],
              ),
            ],
          ).expanded(),
          TextButton(child: Icon(Icons.chevron_right_outlined, color: green), onPressed: (){}),
        ],
      ),
    );
  }
}