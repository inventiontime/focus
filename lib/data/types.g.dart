// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'types.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PreferencesAdapter extends TypeAdapter<Preferences> {
  @override
  final int typeId = 1;

  @override
  Preferences read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Preferences()
      ..workTime = fields[0] as int
      ..breakTime = fields[1] as int
      ..workAlarm = fields[2] as int
      ..breakAlarm = fields[3] as int
      ..nextTagId = fields[4] as int;
  }

  @override
  void write(BinaryWriter writer, Preferences obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.workTime)
      ..writeByte(1)
      ..write(obj.breakTime)
      ..writeByte(2)
      ..write(obj.workAlarm)
      ..writeByte(3)
      ..write(obj.breakAlarm)
      ..writeByte(4)
      ..write(obj.nextTagId);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PreferencesAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class TagAdapter extends TypeAdapter<Tag> {
  @override
  final int typeId = 2;

  @override
  Tag read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Tag(
      id: fields[0] as int,
      name: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Tag obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TagAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class SessionAdapter extends TypeAdapter<Session> {
  @override
  final int typeId = 3;

  @override
  Session read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Session(
      time: fields[0] as int,
      day: fields[1] as int,
      hour: fields[2] as int,
      details: fields[3] as bool,
      tagId: fields[4] as int,
      productivity: fields[5] as int,
    );
  }

  @override
  void write(BinaryWriter writer, Session obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.time)
      ..writeByte(1)
      ..write(obj.day)
      ..writeByte(2)
      ..write(obj.hour)
      ..writeByte(3)
      ..write(obj.details)
      ..writeByte(4)
      ..write(obj.tagId)
      ..writeByte(5)
      ..write(obj.productivity);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SessionAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
