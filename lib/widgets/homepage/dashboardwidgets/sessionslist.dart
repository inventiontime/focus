import 'package:flutter/material.dart';
import 'package:focus/data.dart';
import 'package:focus/data/appdata.dart';
import 'package:focus/data/storage.dart';
import 'package:focus/functions.dart';
import 'package:focus/widgets/components.dart';
import 'package:focus/widgets/homepage/dashboardwidgets/headings.dart';
import 'package:focus/widgets/modulewidgets.dart';
import 'package:intl/intl.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:focus/modifiers.dart';

class SessionList extends StatefulWidget {
  SessionList({Key key}) : super(key: key);

  @override
  _SessionListState createState() => _SessionListState();
}

class _SessionListState extends State<SessionList> {
  bool isLoading = false;
  List<Widget> sessionCards = [];
  int increment = 10;
  int totalLength = 0;
  int totalSessions = appData.sessions.length;

  bool editDialog = false;
  bool cancelled;
  int productivity;
  int tagId;

  void delete(Key key) {
    setState(() => isLoading = true);
    int index = sessionCards.indexWhere((element) => element.key == key);

    Storage.storage.deleteSession(totalSessions - index - 1);
    totalSessions--;
    sessionCards.removeAt(index);

    setState(() => isLoading = false);
  }

  void edit(Key key) async {
    int index = sessionCards.indexWhere((element) => element.key == key);

    productivity = appData.sessions[totalSessions - index - 1].productivity;
    tagId = appData.sessions[totalSessions - index - 1].tagId;
    setState(() => editDialog = true);
    while (editDialog == true) {
      await new Future.delayed(new Duration(seconds: 1));
    }

    if (!cancelled) {
      setState(() => isLoading = true);
      Storage.storage.addSessionDetails(tagId, productivity,
          index: totalSessions - index - 1);

      sessionCards.removeAt(index);
      sessionCards.insert(
          index,
          SessionCard(totalSessions - index - 1, edit, delete,
              key: UniqueKey()));

      setState(() => isLoading = false);
    }
  }

  void generate() {
    setState(() => isLoading = true);
    if (totalLength < totalSessions) {
      totalLength += increment;
      if (totalLength > totalSessions) totalLength = totalSessions;
      sessionCards += List<Widget>.generate(
          totalLength - sessionCards.length,
          (int index) => SessionCard(
              totalSessions - (index + sessionCards.length) - 1, edit, delete,
              key: UniqueKey()));
    }
    setState(() => isLoading = false);
  }

  @override
  void initState() {
    super.initState();
    generate();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Column(children: [
        StatsHeading(name: "Sessions", child: Container()),
        SizedBox(height: 40),
        LazyLoadScrollView(
          isLoading: isLoading,
          onEndOfPage: generate,
          child:
              Scrollbar(child: ListView(children: List.castFrom(sessionCards))),
        ).expanded(),
      ]),
      if (editDialog)
        BackgroundBox(
          color: backgroundColor2,
          child: Row(children: [
            Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ChooseProductivity(
                      onChanged: (int value) {
                        productivity = value;
                      },
                      startingValue: productivity),
                  Divider(height: 50),
                  ChooseTag(
                      onSelected: (int value) {
                        tagId = value;
                      },
                      startingValue: tagId),
                ]).expanded(),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextButton(
                    child: Icon(Icons.done_outlined, size: 30, color: green),
                    onPressed: () {
                      cancelled = false;
                      setState(() => editDialog = false);
                    }),
                SizedBox(height: 30),
                TextButton(
                    child: Icon(Icons.clear_outlined, size: 30, color: red),
                    onPressed: () {
                      cancelled = true;
                      setState(() => editDialog = false);
                    }),
              ],
            ).padding(30),
          ]),
        ),
    ]);
  }
}

class SessionCard extends StatelessWidget {
  SessionCard(this.index, this.edit, this.delete, {Key key})
      : day = DateFormat('LLL d')
            .format(getDateFromDay(appData.sessions[index].day)),
        overAt = appData.sessions[index].hour.toString() +
            ':' +
            appData.sessions[index].minute.toString(),
        time = appData.sessions[index].time.toString() + ' min',
        productivity = appData.sessions[index].productivity.toString() + '%',
        tag = appData.tagOfId(appData.sessions[index].tagId),
        super(key: key);

  final int index;
  final Function(Key key) edit;
  final Function(Key key) delete;

  final String day;
  final String overAt;
  final String time;
  final String productivity;
  final String tag;

  @override
  Widget build(BuildContext context) {
    return index == 0
        ? Card(
            child: ListTile(
              title: Row(
                children: [
                  SessionCardText('end of list').expanded(),
                ],
              ),
              tileColor: backgroundColor2,
            ),
          )
        : Card(
            child: ListTile(
              leading: TextButton(
                  child: Icon(Icons.create_outlined, color: red),
                  onPressed: () {
                    edit(key);
                  }),
              title: Row(
                children: [
                  SessionCardText(day).expanded(),
                  SessionCardText(overAt).expanded(),
                  SessionCardText(time).expanded(),
                  SessionCardText(productivity).expanded(),
                  SessionCardText(tag).expanded(),
                ],
              ),
              trailing: TextButton(
                  child: Icon(Icons.delete_outlined, color: blue),
                  onPressed: () {
                    delete(key);
                  }),
              tileColor: backgroundColor2,
            ),
          );
  }
}

class SessionCardText extends StatelessWidget {
  SessionCardText(this.text);
  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(text,
        style: Theme.of(context).textTheme.bodyText2,
        textAlign: TextAlign.center);
  }
}
