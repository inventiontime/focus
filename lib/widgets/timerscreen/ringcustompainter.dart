import 'dart:math';

import 'package:flutter/material.dart';

class RingCustomPainter extends CustomPainter {
  RingCustomPainter({
    this.animation,
    this.color,
    this.backgroundColor
  }) : super(repaint: animation);
  final Animation<double> animation;
  final Color color, backgroundColor;

  @override
  void paint(Canvas canvas, Size size) {
    Offset center = Offset(size.width / 2, size.height / 2);
    double radius = min(size.width / 2, size.height / 2);
    double startRadian = -pi / 2;
    double progress = (1.0 - animation.value) * 2 * pi;

    var paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = min(size.width / 10, size.height / 10)
      ..color = backgroundColor
      ..strokeCap = StrokeCap.butt;
    canvas.drawCircle(center, radius, paint);

    paint.color = color;
    canvas.drawArc(Rect.fromCircle(center: center, radius: radius),
        startRadian, progress, false, paint);
    }

  @override
  bool shouldRepaint(RingCustomPainter old) {
    return animation.value != old.animation.value ||
        color != old.color ||
        backgroundColor != old.backgroundColor;
  }
}