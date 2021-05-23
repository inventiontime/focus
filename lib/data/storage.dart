import 'package:focus/data/appdata.dart';
import 'package:focus/data/types.dart';
import 'package:focus/functions.dart';
import 'package:hive/hive.dart';
import 'package:dart_app_data/dart_app_data.dart' as path;

class Storage {
  static final Storage storage = Storage();

  final myData = path.AppData.findOrCreate('Focus');

  Future<String> get localPath async {
    var x = myData.directory;
    return x.path;
  }

  Box<int> preferencesBox;
  Box<Tag> tagBox;
  Box<Session> sessionBox;

  Future<void> read() async {
    Hive.init(await localPath);

    Hive.registerAdapter(TagAdapter());
    Hive.registerAdapter(SessionAdapter());

    preferencesBox = await Hive.openBox<int>('preferencesBoxV1');
    tagBox = await Hive.openBox<Tag>('tagBoxV1');
    sessionBox = await Hive.openBox<Session>('sessionBoxV1');

    await initialize();

    return;
  }

  Future<void> initialize() async {
    for(int i = 0; i < Preference.values.length; i++) {
      if (getPreference(Preference.values[i]) == null) setPreference(Preference.values[i], defaultPreferences[Preference.values[i]]);
    }
    if (tagBox.isEmpty) await tagBox.addAll(defaultTags);
    if (sessionBox.isEmpty) addSession(0);
    return;
  }

  int getPreference(Preference preference) {
    return appData.preferences[preference.index];
  }

  void setPreference(Preference preference, int value) {
    preferencesBox.put(preference.index, value);
  }

  void addToPreference(Preference preference, int value) {
    preferencesBox.put(preference.index, appData.preferences[preference.index]+value);
  }

  int nextTagId() {
    int id = appData.preferences[Preference.nextTagId.index];
    preferencesBox.put(Preference.nextTagId.index, appData.preferences[Preference.nextTagId.index]+1);
    return id;
  }

  void addTag(String name) {
    tagBox.add(new Tag(id: nextTagId(), name: name));
  }

  void renameTag(int index, String name) {
    appData.tags[index].name = name;
    tagBox.putAt(index, appData.tags[index]);
  }

  void deleteTag(int index) {
    tagBox.deleteAt(index);
  }

  void addSession(int time) {
    sessionBox.add(Session(time: time, day: day(), hour: hour()));
  }

  void addSessionDetails(int tagId, int productivity) {
    appData.sessions.last.details = true;
    appData.sessions.last.tagId = tagId;
    appData.sessions.last.productivity = productivity;

    sessionBox.putAt(sessionBox.length - 1, appData.sessions.last);
  }

  Future<void> clearData() async {
    await preferencesBox.clear();
    await tagBox.clear();
    await sessionBox.clear();

    await initialize();

    return;
  }
}
