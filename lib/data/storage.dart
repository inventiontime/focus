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

  Box<Preferences> preferencesBox;
  Box<Tag> tagBox;
  Box<Session> sessionBox;

  Future<void> read() async {
    Hive.init(await localPath);

    if (!Hive.isAdapterRegistered(PreferencesAdapter().typeId))
      Hive.registerAdapter(PreferencesAdapter());
    if (!Hive.isAdapterRegistered(TagAdapter().typeId))
      Hive.registerAdapter(TagAdapter());
    if (!Hive.isAdapterRegistered(SessionAdapter().typeId))
      Hive.registerAdapter(SessionAdapter());

    preferencesBox = await Hive.openBox<Preferences>('preferencesBoxV1');
    tagBox = await Hive.openBox<Tag>('tagBoxV1');
    sessionBox = await Hive.openBox<Session>('sessionBoxV1');

    if (preferencesBox.isEmpty) preferencesBox.add(new Preferences());

    if (tagBox.isEmpty) tagBox.addAll(defaultTags);

    if (sessionBox.isEmpty) addSession(0);

    return;
  }

  void writePreferences() {
    preferencesBox.putAt(0, appData.preferences);
  }

  int nextTagId() {
    int id = appData.preferences.nextTagId;
    appData.preferences.nextTagId++;
    preferencesBox.putAt(0, appData.preferences);
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

    if (preferencesBox.isEmpty) preferencesBox.add(new Preferences());

    if (tagBox.isEmpty) tagBox.addAll(defaultTags);

    if (sessionBox.isEmpty) addSession(0);

    return;
  }
}
