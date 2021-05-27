import 'package:flutter/material.dart';
import 'package:focus/modifiers.dart';
import 'package:focus/data.dart';

class Sidebar extends StatelessWidget {
  final double spacing = 50;
  final double widthFactor = 0.4;
  @override
  Widget build(BuildContext context) {
    return new LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return Stack(alignment: Alignment.center, children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Tooltip(
                child: TextButton(
                  child: Icon(Icons.assessment_outlined,
                      size: constraints.maxWidth * widthFactor, color: gray),
                  onPressed: () {
                    Navigator.pushNamed(context, 'dashboard');
                  },
                ),
                message: 'Dashboard',
              ),
              SizedBox(height: 10),
              // Text('DASHBOARD', style: Theme.of(context).textTheme.subtitle1),
              SizedBox(height: spacing),
              Tooltip(
                child: TextButton(
                  child: Icon(Icons.alarm_add_outlined,
                      size: constraints.maxWidth * widthFactor, color: gray),
                  onPressed: () {
                    Navigator.pushNamed(context, 'timer');
                  },
                ),
                message: 'Timer',
              ),
              SizedBox(height: 10),
              // Text('TIMER', style: Theme.of(context).textTheme.subtitle1),
              SizedBox(height: spacing),
              Tooltip(
                child: TextButton(
                  child: Icon(Icons.settings_outlined,
                      size: constraints.maxWidth * widthFactor, color: gray),
                  onPressed: () {
                    Navigator.pushNamed(context, 'settings');
                  },
                ),
                message: 'Settings',
              ),
              SizedBox(height: 10),
              // Text('SETTINGS', style: Theme.of(context).textTheme.subtitle1),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container().expanded(),
              Tooltip(
                child: TextButton(
                  child: Icon(Icons.help_outline,
                      size: constraints.maxWidth * widthFactor, color: gray),
                  onPressed: () {
                    Navigator.pushNamed(context, 'help');
                  },
                ),
                message: 'Help',
              ),
              SizedBox(height: 30),
            ],
          ),
        ]);
      },
    );
  }
}
