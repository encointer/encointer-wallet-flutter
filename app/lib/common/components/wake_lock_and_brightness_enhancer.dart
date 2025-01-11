import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:screen_brightness/screen_brightness.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

import 'package:encointer_wallet/service/log/log_service.dart';

/// Simple widget that sets the brightness and keeps the screen awake as long as the widget is alive.
///
/// Useful when a QR-code is shown.
class WakeLockAndBrightnessEnhancer extends StatefulWidget {
  const WakeLockAndBrightnessEnhancer({super.key, required this.brightness});

  /// Brightness of the screen in the interval of [0,1].
  final double brightness;

  @override
  State<WakeLockAndBrightnessEnhancer> createState() => _WakeLockAndBrightnessEnhancerState();
}

class _WakeLockAndBrightnessEnhancerState extends State<WakeLockAndBrightnessEnhancer> {
  Future<void> setBrightness(double brightness) async {
    try {
      await ScreenBrightness().setApplicationScreenBrightness(brightness);
    } catch (e, s) {
      Log.e('$e', 'WakeLockAndBrightnessEnhancer', s);
      throw Exception('Failed to set brightness');
    }
  }

  Future<void> resetBrightness() async {
    try {
      await ScreenBrightness().resetApplicationScreenBrightness();
    } catch (e, s) {
      Log.e('$e', 'WakeLockAndBrightnessEnhancer', s);
      throw Exception('Failed to reset brightness');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }

  @override
  void initState() {
    super.initState();

    WakelockPlus.enable();
    setBrightness(widget.brightness);
  }

  @override
  void dispose() {
    WakelockPlus.disable();
    resetBrightness();
    super.dispose();
  }
}
