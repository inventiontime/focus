import 'package:focus/data/storage.dart';
import 'package:focus/data/types.dart';

class AppData {
  static final AppData _appData = new AppData._internal();

  Preferences get preferences => Storage.storage.preferencesBox.values.first;
  List<Tag> get tags => Storage.storage.tagBox.values.toList();
  List<Session> get sessions => Storage.storage.sessionBox.values.toList();

  int totalWorkTime = 0;
  double productivity = 0;

  int setNumber = 1;

  factory AppData() {
    return _appData;
  }
  AppData._internal();
}

final appData = AppData();