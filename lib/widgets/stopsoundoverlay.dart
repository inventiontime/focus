import 'package:flutter/material.dart';
import 'package:focus/audio.dart';
import 'package:focus/data.dart';
import 'package:focus/modifiers.dart';

class StopSoundOverlay extends StatelessWidget {
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: StopSoundOverlayLoader.appLoader.loaderShowingNotifier,
      builder: (context, value, child) {
        if (value) {
          return StopSoundOverlayWidget();
        } else {
          return Container();
        }
      },
    );
  }
}

class StopSoundOverlayWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: 30,
      top: 30,
      child: Material(
        color: backgroundColor3,
        borderRadius: BorderRadius.circular(20),
        elevation: 10,
        child: TextButton(
          child: Icon(Icons.alarm_off_outlined, size: 30),
          onPressed: () {
            audio.stopAlarm();
          },
        ).padding(10),
      ),
    );
  }
}

class StopSoundOverlayLoader {
  static final StopSoundOverlayLoader appLoader = StopSoundOverlayLoader();
  ValueNotifier<bool> loaderShowingNotifier = ValueNotifier(false);

  void showLoader() {
    loaderShowingNotifier.value = true;
  }

  void hideLoader() {
    loaderShowingNotifier.value = false;
  }
}
