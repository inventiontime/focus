import 'package:focus/data/storage.dart';
import 'package:focus/data/types.dart';

class AppData {
  static final AppData _appData = new AppData._internal();

  Map<dynamic, int> get preferences => Storage.storage.preferencesBox.toMap();
  List<Tag> get tags => Storage.storage.tagBox.values.toList();
  List<Session> get sessions => Storage.storage.sessionBox.values.toList();

  String tagOfId(int tagId) => tags
      .firstWhere((tag) => tag.id == tagId,
          orElse: () => Tag(id: -1, name: '(deleted)'))
      .name;

  int setNumber = 1;

  factory AppData() {
    return _appData;
  }
  AppData._internal();
}

final appData = AppData();
