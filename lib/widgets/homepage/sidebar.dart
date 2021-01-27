import 'package:flutter/material.dart';
import 'package:focus/data.dart';

class Sidebar extends StatelessWidget {
  final double spacing = 50;
  final double widthFactor = 0.4;
  @override
  Widget build(BuildContext context) {
    return new LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                child: Icon(Icons.assessment_outlined, size: constraints.maxWidth * widthFactor, color: gray),
                onPressed: () {Navigator.pushNamed(context, 'dashboard');},
              ),
              SizedBox(height: 10),
              // Text('DASHBOARD', style: Theme.of(context).textTheme.subtitle1),
              SizedBox(height: spacing),
              TextButton(
                child: Icon(Icons.alarm_add_outlined, size: constraints.maxWidth * widthFactor, color: gray),
                onPressed: () {Navigator.pushNamed(context, 'timer');},
              ),
              SizedBox(height: 10),
              // Text('TIMER', style: Theme.of(context).textTheme.subtitle1),
              SizedBox(height: spacing),
              TextButton(
                child: Icon(Icons.settings_outlined, size: constraints.maxWidth * widthFactor, color: gray),
                onPressed: () {Navigator.pushNamed(context, 'settings');},
              ),
              SizedBox(height: 10),
              // Text('SETTINGS', style: Theme.of(context).textTheme.subtitle1),
            ],
          );
        },
      );
  }
}