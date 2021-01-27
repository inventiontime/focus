import 'dart:io';

import 'package:dart_app_data/dart_app_data.dart' as path;
import 'package:focus/data/appdata.dart';

class Storage {
  final myData = path.AppData.findOrCreate('Focus');

  static Storage storage = Storage();
  final String pattern = '//';

  Future<String> get _localPath async {
    var x = myData.directory;
    return x.path;
  }

  /////////////////

  Future<File> get _tagsFile async {
    final path = await _localPath;
    return File('$path/tags.txt');
  }

  void readTags() async {
    try {
      final file = await _tagsFile;
      List<String> contents = (await file.readAsString()).split(pattern);
      appData.tagNumber = int.parse(contents[0]);
      appData.tags = contents.sublist(1, (appData.tagNumber+1));
      appData.tagTime = contents.sublist(appData.tagNumber+1).map(int.parse).toList();
    } catch (e) {}
  }

  Future<File> writeTags() async {
    final file = await _tagsFile;
    String data = "";

    data += appData.tagNumber.toString();

    appData.tags.forEach((String E){
      data += pattern;
      data += E;
    });

    appData.tagTime.forEach((int E){
      data += pattern;
      data += E.toString();
    });

    return file.writeAsString(data);
  }

  /////////////////

  Future<File> get _dataFile async {
    final path = await _localPath;
    return File('$path/data.txt');
  }

  void readData() async {
    try {
      final file = await _dataFile;
      List<String> contents = (await file.readAsString()).split(pattern);

      appData.workTime = int.parse(contents[0]);
      appData.breakTime = int.parse(contents[1]);
      appData.totalWorkTime = int.parse(contents[2]);
      appData.productivity = double.parse(contents[3]);
      appData.workAlarm = int.parse(contents[4]);
      appData.breakAlarm = int.parse(contents[5]);
    } catch (e) {}
  }

  Future<File> writeData() async {
    final file = await _dataFile;
    String data = "";

    data += appData.workTime.toString();
    data += pattern;
    data += appData.breakTime.toString();
    data += pattern;
    data += appData.totalWorkTime.toString();
    data += pattern;
    data += appData.productivity.toString();
    data += pattern;
    data += appData.workAlarm.toString();
    data += pattern;
    data += appData.breakAlarm.toString();

    return file.writeAsString(data);
  }

  /////////////////

  void read() {
    readData();
    readTags();
  }

  void write() {
    writeData();
    writeTags();
  }
}