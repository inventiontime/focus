import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';
import 'package:focus/data.dart';
import 'package:focus/modifiers.dart';

// Unused file due to unforseen issues

/*
Add these 2 lines at the beginning of windows\runner\main.cpp

#include <bitsdojo_window_windows/bitsdojo_window_plugin.h>
auto bdw = bitsdojo_window_configure(BDW_CUSTOM_FRAME | BDW_HIDE_ON_STARTUP);

*/

class WindowTitleBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(color: backgroundColor),
        child: WindowTitleBarBox(
            child: Row(children: [
          MoveWindow().expanded(),
          WindowButtons(),
        ])));
  }
}

class WindowButtons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(children: [
      MinimizeWindowButton(),
      MaximizeWindowButton(),
      CloseWindowButton(),
    ]);
  }
}
