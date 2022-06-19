import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:screen_brightness/screen_brightness.dart';
import 'package:wakelock/wakelock.dart';

/// Simple widget that sets the brightness and keeps the screen awake as long as the widget is alive.
///
/// Useful when a QR-code is shown.
class WakeLockAndBrightnessEnhancer extends StatefulWidget {
  const WakeLockAndBrightnessEnhancer({
    Key key,
    @required this.brightness,
  }) : super(key: key);

  /// Brightness of the screen in the interval of [0,1].
  final double brightness;

  @override
  _WakeLockAndBrightnessEnhancerState createState() => _WakeLockAndBrightnessEnhancerState();
}

class _WakeLockAndBrightnessEnhancerState extends State<WakeLockAndBrightnessEnhancer> {
  Future<void> setBrightness(double brightness) async {
    try {
      await ScreenBrightness().setScreenBrightness(brightness);
    } catch (e) {
      print(e);
      throw 'Failed to set brightness';
    }
  }

  Future<void> resetBrightness() async {
    try {
      await ScreenBrightness().resetScreenBrightness();
    } catch (e) {
      print(e);
      throw 'Failed to reset brightness';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }

  @override
  void initState() {
    super.initState();

    Wakelock.enable();
    setBrightness(widget.brightness);
  }

  @override
  void dispose() {
    Wakelock.disable();
    resetBrightness();
    super.dispose();
  }
}
