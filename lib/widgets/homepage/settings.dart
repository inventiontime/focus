import 'package:flutter/material.dart';
import 'package:focus/data/appdata.dart';
import 'package:focus/audio.dart';
import 'package:focus/data.dart';
import 'package:focus/data/storage.dart';
import 'package:focus/widgets/components.dart';
import 'package:focus/modifiers.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  Future<String> renameDialog() async {
    TextEditingController controller = new TextEditingController();

    return await showDialog<String>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: new TextField(
              controller: controller,
              style: Theme.of(context).textTheme.bodyText2,
              autofocus: true,
              autocorrect: false,
              decoration: new InputDecoration(labelText: 'Name', hintText: 'Tag Name'),
            ),
            actions: <Widget>[
              new TextButton(
                  child: const Text('CANCEL'),
                  onPressed: () {
                    Navigator.pop(context, null);
                  }
              ),
              new TextButton(
                child: const Text('SAVE'),
                onPressed: () {
                  Navigator.pop(context, controller.text);
                }
              ),
            ]
          );
        }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        BackgroundBox(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Tags', style: Theme.of(context).textTheme.headline3),
              SizedBox(height: 20),
              ListView(
                children: List<Widget>.generate(appData.tags.length+1,
                  (int index) { return (index < appData.tags.length) ? TagCard(index, this) : AddCard(this); }
                ),
              ).expanded(),
            ]
          ).padding(20)
        ).expanded(),
        SizedBox(width: 20),
        BackgroundBox(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Work Alarm Sound', style: Theme.of(context).textTheme.headline3),
              SizedBox(height: 20),
              ChooseAlarm(true),
              SizedBox(height: 40),
              Text('Break Alarm Sound', style: Theme.of(context).textTheme.headline3),
              SizedBox(height: 20),
              ChooseAlarm(false),
            ]
          ).padding(20).scrollable(),
        ).expanded(),
      ],
    );
  }

  void _setState() => setState((){});
}

class TagCard extends StatelessWidget {
  TagCard(this.index, this.parent);
  final int index;
  final _SettingsState parent;

  void rename(int index) async {
    String s = await parent.renameDialog();
    if(s == null) return;

    Storage.storage.renameTag(index, s);
    parent._setState();
  }

  void delete(int index) {
    Storage.storage.deleteTag(index);
    parent._setState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: TextButton(child: Icon(Icons.create_outlined, color: red), onPressed: (){rename(index);}),
        title: Text(appData.tags[index].name, style: Theme.of(context).textTheme.bodyText2),
        trailing: TextButton(child: Icon(Icons.delete, color: blue), onPressed: (){delete(index);}),
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
    if(s == null) return;

    Storage.storage.addTag(s);
    parent._setState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Icon(Icons.add),
        title: Text('Add Card', style: Theme.of(context).textTheme.bodyText2),
        onTap: (){add();},
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

    value = (widget.isWork) ? appData.preferences.workAlarm : appData.preferences.breakAlarm;
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 10,
      runSpacing: 15,
      children: List<Widget>.generate(alarms.length,
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
                (widget.isWork) ? appData.preferences.workAlarm = value : appData.preferences.breakAlarm = value;
                audio.playPreview(index);
                Storage.storage.writePreferences();
              });
            },
          );
        },
      ).toList(),
    );
  }
}
