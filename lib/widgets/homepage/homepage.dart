import 'package:flutter/material.dart';
import 'package:focus/data.dart';
import 'package:focus/enum.dart';
import 'package:focus/widgets/homepage/dashboard.dart';
import 'package:focus/widgets/homepage/settings.dart';
import 'package:focus/widgets/homepage/sidebar.dart';
import 'package:focus/modifiers.dart';
import 'package:focus/widgets/homepage/timer.dart';

class HomePage extends StatelessWidget {
  @override
  HomePage(this.type);
  final HomePageType type;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Row (
        children: [
          Container(
            width: 90,
            child: Sidebar(),
          ),
          Container(
            decoration: BoxDecoration(color: backgroundColor2, borderRadius: BorderRadius.circular(20)),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(type.toString().substring(13).capitalize(), style: Theme.of(context).textTheme.headline1),
                  SizedBox(height: 40),
                  if(type == HomePageType.dashboard) Dashboard().expanded()
                  else if(type == HomePageType.timer) Timer().expanded()
                  else if(type == HomePageType.settings) Settings().expanded(),
                ]
            ).padding(40),
          ).paddingLTRB(0, 40, 40, 40).expanded(),
        ],
      ),
    );
  }
}