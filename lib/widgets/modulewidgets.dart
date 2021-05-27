import 'package:flutter/material.dart';
import 'package:focus/data.dart';
import 'package:focus/data/appdata.dart';
import 'package:focus/modifiers.dart';

class ChooseProductivity extends StatefulWidget {
  const ChooseProductivity({this.onChanged, this.startingValue});
  final int startingValue;
  final void Function(int productivity) onChanged;

  @override
  _ChooseProductivityState createState() => _ChooseProductivityState();
}

class _ChooseProductivityState extends State<ChooseProductivity> {
  double productivity;

  @override
  void initState() {
    super.initState();
    productivity = widget.startingValue.toDouble();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text('productivity', style: Theme.of(context).textTheme.headline3),
        SizedBox(height: 20),
        Slider(
          value: productivity,
          min: 30,
          max: 100,
          divisions: 14,
          label: productivity.round().toString(),
          onChanged: widget.onChanged == null
              ? null
              : (double value) {
                  setState(() {
                    productivity = value;
                    widget.onChanged(productivity.round());
                  });
                },
        ),
      ],
    );
  }
}

class ChooseTag extends StatefulWidget {
  ChooseTag({this.onSelected, this.startingValue});
  final int startingValue;
  final void Function(int tagId) onSelected;

  @override
  _ChooseTagState createState() => _ChooseTagState();
}

class _ChooseTagState extends State<ChooseTag> {
  int tagIndex = 0;

  @override
  void initState() {
    super.initState();
    tagIndex = widget.startingValue == null
        ? 0
        : appData.tags.indexWhere(
            (tag) => tag.name == appData.tagOfId(widget.startingValue));
    if (tagIndex == -1) tagIndex = 0;
  }

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
