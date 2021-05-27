import 'package:dart_vlc/dart_vlc.dart';
import 'package:focus/data/appdata.dart';
import 'package:focus/data.dart';
import 'package:focus/data/types.dart';
import 'package:focus/widgets/stopsoundoverlay.dart';

class Audio {
  static final Audio _audio = new Audio._internal();

  Player player = new Player(id: 1);

  void playWorkAlarm() async {
    await player.open(await Media.asset(
        alarmPaths[appData.preferences[Preference.workAlarm.index]]));
    StopSoundOverlayLoader.appLoader.showLoader();
  }

  void playBreakAlarm() async {
    await player.open(await Media.asset(
        alarmPaths[appData.preferences[Preference.breakAlarm.index]]));
    StopSoundOverlayLoader.appLoader.showLoader();
  }

  void playPreview(int index) async {
    await player.open(await Media.asset(alarmPaths[index]));
    StopSoundOverlayLoader.appLoader.showLoader();
  }

  void stopAlarm() {
    player.stop();
    StopSoundOverlayLoader.appLoader.hideLoader();
  }

  factory Audio() {
    return _audio;
  }
  Audio._internal();
}

final audio = Audio();
