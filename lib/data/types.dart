import 'package:hive/hive.dart';

part 'types.g.dart';

@HiveType(typeId: 1)
class Tag {
  Tag({this.id, this.name});

  @HiveField(0)
  int id;
  @HiveField(1)
  String name;
}

@HiveType(typeId: 2)
class Session {
  Session(
      {this.time,
      this.day,
      this.hour,
      this.details = false,
      this.tagId = -1,
      this.productivity = -1});

  @HiveField(0)
  int time; // how long session was
  @HiveField(1)
  int day; // day on which session was completed
  @HiveField(2)
  int hour;
  @HiveField(3)
  bool details; // set to true when tagId/productivity is set
  @HiveField(4)
  int tagId;
  @HiveField(5)
  int productivity;
}

List<Tag> defaultTags = [
  Tag(id: 1, name: 'Mathematics'),
  Tag(id: 2, name: 'Physics'),
  Tag(id: 3, name: 'Chemistry'),
  Tag(id: 4, name: 'Biology'),
  Tag(id: 5, name: 'Others'),
];

enum Preference {
  workTime,
  breakTime,
  workAlarm,
  breakAlarm,
  nextTagId,
}

Map<Preference, int> defaultPreferences = {
  Preference.workTime : 30,
  Preference.breakTime : 5,
  Preference.workAlarm : 0,
  Preference.breakAlarm : 1,
  Preference.nextTagId : 20,
};
