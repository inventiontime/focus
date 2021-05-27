import 'package:flutter/material.dart';
import 'package:focus/data.dart';

class BackgroundBox extends StatelessWidget {
  @override
  BackgroundBox({this.child, Color color})
      : this.color = (color == null ? backgroundColor3 : color);
  final Widget child;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(child: child),
    );
  }
}

class RowText extends StatelessWidget {
  RowText(this.text1, this.text2, {this.style1, this.style2});
  final String text1;
  final String text2;
  final TextStyle style1;
  final TextStyle style2;

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(text: text1, style: style1, children: <TextSpan>[
        TextSpan(
          text: text2,
          style: style2,
        ),
      ]),
    );
  }
}

class SelectedBox extends StatelessWidget {
  SelectedBox({this.child, this.selected});

  final Widget child;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(13),
        decoration: BoxDecoration(
          border: Border.all(
              color: blue.withOpacity((selected) ? 0.5 : 0.0), width: 10),
          borderRadius: BorderRadius.circular(10),
        ),
        child: child);
  }
}
