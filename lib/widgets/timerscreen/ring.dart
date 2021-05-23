import 'package:flutter/material.dart';

import 'ringcustompainter.dart';

class Ring extends StatelessWidget {
  Ring({this.controller, this.color});
  final Animation<double> controller;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Center(
        child: FractionallySizedBox(
      widthFactor: 0.5,
      heightFactor: 0.5,
      child: AnimatedBuilder(
        animation: controller,
        builder: (BuildContext context, Widget child) {
          return CustomPaint(
              painter: RingCustomPainter(
            animation: controller,
            backgroundColor: color.withOpacity(0.15),
            color: color,
          ));
        },
      ),
    ));
  }
}
