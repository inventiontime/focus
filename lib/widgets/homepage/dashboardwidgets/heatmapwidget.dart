import 'package:flutter/material.dart';
import 'package:focus/data.dart';
import 'package:heatmap_calendar/heatmap_calendar.dart';

class HeatmapWidget extends StatelessWidget {
  HeatmapWidget({this.input, this.colorThresholds, this.labelTextColor});
  Map<DateTime, int> input;
  Map<int, Color> colorThresholds;
  Color labelTextColor;

  @override
  Widget build(BuildContext context) {
    return HeatMapCalendar(
      input: input,
      colorThresholds: colorThresholds,
      weekDaysLabels: ['S', 'M', 'T', 'W', 'T', 'F', 'S'],
      monthsLabels: [
        "",
        "Jan",
        "Feb",
        "Mar",
        "Apr",
        "May",
        "Jun",
        "Jul",
        "Aug",
        "Sep",
        "Oct",
        "Nov",
        "Dec",
      ],
      squareSize: 25.0,
      textOpacity: 0.5,
      labelTextColor: labelTextColor,
      dayTextColor: foregroundColor,
    );
  }
}
