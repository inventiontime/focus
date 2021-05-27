import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:focus/data.dart';
import 'package:focus/data/appdata.dart';
import 'package:focus/widgets/homepage/dashboardwidgets/headings.dart';
import 'package:focus/functions.dart' as functions;
import 'package:focus/modifiers.dart';

class DayChart extends StatefulWidget {
  const DayChart({Key key}) : super(key: key);

  @override
  _DayChartState createState() => _DayChartState();
}

class _DayChartState extends State<DayChart> {
  final Color gridColor = Color(0xff37434d);
  final TextStyle titleStyle = TextStyle(
      fontFamily: 'Euclid',
      color: Colors.white60,
      fontWeight: FontWeight.bold,
      fontSize: 13);
  List<Color> gradientColors = [
    blue,
    green,
  ];

  int day;

  List<FlSpot> spots = [];

  @override
  void initState() {
    super.initState();
    getDayStats(functions.day());
  }

  void dayProductivity() {
    spots.clear();
    for (int i = appData.sessions.length - 1; i >= 0; i--) {
      int hour = appData.sessions[i].hour;
      int min = appData.sessions[i].minute;
      int time = appData.sessions[i].time;
      int prod = appData.sessions[i].productivity;
      if (appData.sessions[i].day < day)
        break;
      else if (appData.sessions[i].day == day) if (appData
          .sessions[i].details) {
        spots.add(FlSpot((hour * 60 + min - time) / 60, 3));
        spots.add(FlSpot((hour * 60 + min - time) / 60, prod / 10));
        spots.add(FlSpot((hour * 60 + min) / 60, prod / 10));
        spots.add(FlSpot((hour * 60 + min) / 60, 3));
      }
    }
  }

  void getDayStats(int day) {
    setState(() {
      this.day = day;
      dayProductivity();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      StatsHeading(
        name: "Day Chart",
        child: ChooseDay(onPressed: (int day) {
          getDayStats(day);
        }),
      ),
      SizedBox(height: 40),
      LineChart(
        mainData(),
      ).paddingLTRB(10, 40, 10, 40).expanded(),
    ]);
  }

  LineChartData mainData() {
    return LineChartData(
      gridData: FlGridData(
        show: true,
        drawVerticalLine: true,
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: gridColor,
            strokeWidth: 2,
          );
        },
        getDrawingVerticalLine: (value) {
          return FlLine(
            color: gridColor,
            strokeWidth: 2,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: SideTitles(
          showTitles: true,
          reservedSize: 22,
          getTextStyles: (value) => titleStyle,
          getTitles: (value) {
            return (value < 10 ? '0' : '') + value.round().toString();
          },
          margin: 8,
        ),
        leftTitles: SideTitles(
          showTitles: true,
          getTextStyles: (value) => titleStyle,
          getTitles: (value) {
            return (value * 10).round().toString() + '%';
          },
          reservedSize: 28,
          margin: 12,
        ),
      ),
      borderData: FlBorderData(
          show: true, border: Border.all(color: gridColor, width: 2)),
      minX: 0,
      maxX: 24,
      minY: 3,
      maxY: 10,
      lineBarsData: [
        LineChartBarData(
          spots: spots.reversed.toList(),
          isCurved: false,
          colors: gradientColors,
          barWidth: 5,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: true,
            colors:
                gradientColors.map((color) => color.withOpacity(0.3)).toList(),
          ),
        ),
      ],
      lineTouchData: LineTouchData(enabled: false),
    );
  }
}
