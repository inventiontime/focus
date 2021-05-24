import 'package:flutter/material.dart';
import 'package:focus/data/storage.dart';
import 'package:focus/data/types.dart';
import 'package:focus/modifiers.dart';
import 'package:focus/widgets/components.dart';

class Help extends StatefulWidget {
  @override
  State<Help> createState() => _HelpState();
}

class _HelpState extends State<Help> {
  @override
  void initState() {
    super.initState();
    Storage.storage.setPreference(Preference.helpRead, 1);
  }

  @override
  Widget build(BuildContext context) {
    return BackgroundBox(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        HelpText('This app has been designed to improve concentration and track the use of your time. (scroll down see the rest)').padding(30),
        Divider(),
        SubtitledHelpImage(image: 'assets/images/help/dashboard.png', subtitle: 'The dashboard shows you statistics. (Tip: click the date to chose any day from the calendar)'),
        Divider(),
        SubtitledHelpImage(image: 'assets/images/help/timerScreen.png', subtitle: 'Choose the length of a work session and a short break session on the timer page. (recommended work: 25min break: 5min)'),
        SubtitledHelpImage(image: 'assets/images/help/workTimer.png', subtitle: 'This is the work timer. Work on a single subject/task throughout the timer.\n \n' + 'To skip to the break or end the session, click the three dots in the top left corner.'),
        SubtitledHelpImage(image: 'assets/images/help/breakTimer.png', subtitle: 'During the break, select the tag (tags can be changed in settings) for the session and the productivity % of the session.'),
      ],
    ).scrollable().padding(30));
  }
}

class SubtitledHelpImage extends StatelessWidget {
  SubtitledHelpImage({this.image, this.subtitle});
  final String image;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset(image).padding(30).expanded(),
        HelpText(subtitle).padding(30).expanded(),
      ],
    );
  }
}


class HelpText extends StatelessWidget {
  HelpText(this.text);
  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(text, style: Theme.of(context).textTheme.bodyText2);
  }
}
