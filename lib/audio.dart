import 'package:flutter_audio_desktop/flutter_audio_desktop.dart';
import 'package:focus/data/appdata.dart';
import 'package:focus/data.dart';
import 'package:focus/widgets/stopsoundoverlay.dart';

class Audio {
  static final Audio _audio = new Audio._internal();

  var audioPlayer = new AudioPlayer(id: 0, debug: true);

  void playWorkAlarm() async {
    await audioPlayer.load(alarmPaths[appData.workAlarm]);
    audioPlayer.play();
    StopSoundOverlayLoader.appLoader.showLoader();
  }

  void playBreakAlarm() async {
    await audioPlayer.load(alarmPaths[appData.breakAlarm]);
    audioPlayer.play();
    StopSoundOverlayLoader.appLoader.showLoader();
  }

  void playPreview(int index) async {
    await audioPlayer.load(alarmPaths[index]);
    audioPlayer.play();
    StopSoundOverlayLoader.appLoader.showLoader();
  }

  void stopAlarm() {
    if(audioPlayer.isPlaying)
      audioPlayer.pause();
    StopSoundOverlayLoader.appLoader.hideLoader();
  }

  factory Audio() {
    return _audio;
  }
  Audio._internal();
}

final audio = Audio();