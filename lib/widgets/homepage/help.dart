import 'package:flutter/material.dart';
import 'package:focus/modifiers.dart';
import 'package:focus/widgets/components.dart';

class Help extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BackgroundBox(
        child: Column(
      children: [
        Text("to be completed", style: Theme.of(context).textTheme.bodyText2),
      ],
    ).scrollable().padding(30));
  }
}
