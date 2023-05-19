import 'package:vibration/vibration.dart';

class SettingVibration {
  static Future<void> setVibrate(String times) async {
    switch (times) {
      case "한 번 진동":
        if (await Vibration.hasVibrator() ?? true) {
          Vibration.vibrate();
        }
        break;
      case "두 번 진동":
        if (await Vibration.hasVibrator() ?? true) {
          Vibration.vibrate();
          await Future.delayed(const Duration(milliseconds: 800));
          Vibration.vibrate();
        }
        break;
      case "세 번 진동":
        if (await Vibration.hasVibrator() ?? true) {
          Vibration.vibrate();
          await Future.delayed(const Duration(milliseconds: 800));
          Vibration.vibrate();
          await Future.delayed(const Duration(milliseconds: 800));
          Vibration.vibrate();
        }
        break;
      case "연속 진동":
      int n = 10;
        if (await Vibration.hasVibrator() ?? true) {
          while (n>0) {
            Vibration.vibrate();
            await Future.delayed(const Duration(milliseconds: 700));
            n--;
        }}
        break;
    }
  }
}
