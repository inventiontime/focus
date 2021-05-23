import 'package:flutter/material.dart';
import 'package:focus/data.dart';
import 'package:focus/data/appdata.dart';
import 'package:focus/modifiers.dart';

class BackgroundBox extends StatelessWidget {
  @override
  BackgroundBox({this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor3,
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

class ChooseTag extends StatefulWidget {
  ChooseTag({this.onSelected});
  final void Function(int tagId) onSelected;

  @override
  _ChooseTagState createState() => _ChooseTagState();
}

class _ChooseTagState extends State<ChooseTag> {
  int tagIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text('tags', style: Theme.of(context).textTheme.headline3),
        SizedBox(height: 20),
        Wrap(
          spacing: 10,
          runSpacing: 15,
          children: List<Widget>.generate(
            appData.tags.length,
            (int index) {
              return ChoiceChip(
                selectedColor: orange,
                label: Text(appData.tags[index].name),
                labelStyle: Theme.of(context).textTheme.bodyText2,
                padding: EdgeInsets.all(10),
                selected: tagIndex == index,
                onSelected: widget.onSelected == null
                    ? null
                    : (bool selected) {
                        setState(() {
                          tagIndex = index;
                          widget.onSelected(appData.tags[tagIndex].id);
                        });
                      },
              );
            },
          ).toList(),
        ),
      ],
    ).scrollable();
  }
}
