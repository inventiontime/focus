import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:focus/data/appdata.dart';
import 'package:focus/audio.dart';
import 'package:focus/data.dart';
import 'package:focus/data/storage.dart';
import 'package:focus/data/types.dart';
import 'package:focus/functions.dart';
import 'package:focus/widgets/components.dart';
import 'package:focus/modifiers.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  bool isLoading = false;

  Future<String> renameDialog({String startingText}) async {
    TextEditingController controller = new TextEditingController()
      ..text = startingText;

    return await showDialog<String>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              content: new TextField(
                controller: controller,
                style: Theme.of(context).textTheme.bodyText2,
                autofocus: true,
                autocorrect: false,
                decoration: new InputDecoration(
                    labelText: 'Name', hintText: 'Tag Name'),
              ),
              actions: <Widget>[
                new TextButton(
                    child: const Text('CANCEL'),
                    onPressed: () {
                      Navigator.pop(context, null);
                    }),
                new TextButton(
                    child: const Text('SAVE'),
                    onPressed: () {
                      Navigator.pop(context, controller.text);
                    }),
              ]);
        });
  }

  Future<bool> deleteDialog() async {
    return await showDialog<bool>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              content: Text(
                "Are you sure you'd like to delete all Focus data? This action is irreversible",
                style: Theme.of(context).textTheme.bodyText2,
              ),
              actions: <Widget>[
                new TextButton(
                    child: Text('CANCEL'),
                    onPressed: () {
                      Navigator.pop(context, false);
                    }),
                new OutlinedButton(
                    child: Text('DELETE',
                        style: Theme.of(context).textTheme.bodyText2.copyWith(
                            color: lighten(red, 0.075),
                            fontWeight: FontWeight.bold)),
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(red.withOpacity(0.2))),
                    onPressed: () {
                      Navigator.pop(context, true);
                    }),
              ]);
        });
  }

  void deleteData(BuildContext context) async {
    bool b = await deleteDialog();
    if (b != null) if (b) {
      setState(() {
        isLoading = true;
      });
      await Storage.storage.clearData();
      setState(() {
        isLoading = false;
      });
      Navigator.pushNamed(context, 'settings');
    }
    return;
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? BackgroundBox(child: CircularProgressIndicator())
        : Row(
            children: [
              BackgroundBox(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                    Text('Tags', style: Theme.of(context).textTheme.headline3),
                    SizedBox(height: 20),
                    ListView(
                      children: List<Widget>.generate(appData.tags.length + 1,
                          (int index) {
                        return (index < appData.tags.length)
                            ? TagCard(index, this)
                            : AddCard(this);
                      }),
                    ).expanded(),
                  ]).padding(40))
                  .expanded(),
              SizedBox(width: 20),
              BackgroundBox(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('General',
                          style: Theme.of(context).textTheme.headline3),
                      Divider(height: 50),
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Work Alarm Sound',
                                style: Theme.of(context).textTheme.bodyText1),
                            SizedBox(height: 20),
                            ChooseAlarm(true),
                            SizedBox(height: 30),
                            Text('Break Alarm Sound',
                                style: Theme.of(context).textTheme.bodyText1),
                            SizedBox(height: 20),
                            ChooseAlarm(false),
                            Divider(height: 50),
                            OutlinedButton(
                                onPressed: () {
                                  deleteData(context);
                                },
                                style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(
                                        red.withOpacity(0.2))),
                                child: Text('Clear Data',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText2
                                        .copyWith(
                                            color: lighten(red, 0.075),
                                            fontWeight: FontWeight.bold))),
                          ]).scrollable().expanded(),
                    ]).padding(40),
              ).expanded(),
            ],
          );
  }

  void _setState() => setState(() {});
}

class TagCard extends StatelessWidget {
  TagCard(this.index, this.parent);
  final int index;
  final _SettingsState parent;

  void rename(int index) async {
    String s =
        await parent.renameDialog(startingText: appData.tags[index].name);
    if (s == null) return;

    Storage.storage.renameTag(index, s);
    parent._setState();
  }

  void delete(int index) {
    if(appData.tags.length > 1) {
      Storage.storage.deleteTag(index);
      parent._setState();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: TextButton(
            child: Icon(Icons.create_outlined, color: red),
            onPressed: () {
              rename(index);
            }),
        title: Text(appData.tags[index].name,
            style: Theme.of(context).textTheme.bodyText2),
        trailing: TextButton(
            child: Icon(Icons.delete, color: blue),
            onPressed: () {
              delete(index);
            }),
        tileColor: backgroundColor2,
      ),
    );
  }
}

class AddCard extends StatelessWidget {
  AddCard(this.parent);
  final _SettingsState parent;

  void add() async {
    String s = await parent.renameDialog();
    if (s == null) return;

    Storage.storage.addTag(s);
    parent._setState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Icon(Icons.add),
        title: Text('Add Card', style: Theme.of(context).textTheme.bodyText2),
        onTap: () {
          add();
        },
        tileColor: backgroundColor2,
      ),
    );
  }
}

class ChooseAlarm extends StatefulWidget {
  ChooseAlarm(this.isWork);
  final bool isWork;

  @override
  _ChooseAlarmState createState() => _ChooseAlarmState();
}

class _ChooseAlarmState extends State<ChooseAlarm> {
  int value;

  @override
  void initState() {
    super.initState();

    value = (widget.isWork)
        ? appData.preferences[Preference.workAlarm.index]
        : appData.preferences[Preference.breakAlarm.index];
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 10,
      runSpacing: 15,
      children: List<Widget>.generate(
        alarms.length,
        (int index) {
          return ChoiceChip(
            selectedColor: red,
            label: Text(alarms[index]),
            labelStyle: Theme.of(context).textTheme.bodyText2,
            padding: EdgeInsets.all(10),
            selected: value == index,
            onSelected: (bool selected) {
              setState(() {
                value = index;
                (widget.isWork)
                    ? Storage.storage.setPreference(Preference.workAlarm, value)
                    : Storage.storage.setPreference(Preference.breakAlarm, value);
                audio.playPreview(index);
              });
            },
          );
        },
      ).toList(),
    );
  }
}
