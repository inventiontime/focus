import 'package:hive/hive.dart';

part 'types.g.dart';

@HiveType(typeId : 1)
class Preferences {
  @HiveField(0) int workTime = 30;
  @HiveField(1) int breakTime = 5;

  @HiveField(2) int workAlarm = 0;
  @HiveField(3) int breakAlarm = 1;

  @HiveField(4) int nextTagId = 10;
}

@HiveType(typeId : 2)
class Tag {
  Tag({this.id, this.name});

  @HiveField(0) int id;
  @HiveField(1) String name;
}

@HiveType(typeId : 3)
class Session {
  Session({this.time, this.day, this.hour, this.details = false, this.tagId = -1, this.productivity = -1});

  @HiveField(0) int time; // how long session was
  @HiveField(1) int day; // day on which session was completed
  @HiveField(2) int hour;
  @HiveField(3) bool details; // set to true when tagId/productivity is set
  @HiveField(4) int tagId;
  @HiveField(5) int productivity;
}

List<Tag> defaultTags = [
  Tag(id: 1, name: 'Mathematics'),
  Tag(id: 1, name: 'Physics'),
  Tag(id: 1, name: 'Chemistry'),
  Tag(id: 1, name: 'Biology'),
  Tag(id: 1, name: 'Others'),
];