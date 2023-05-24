import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';


class DropdownButtonController extends GetxService {
  final RxString crySelected = RxString('한 번 진동');
  final RxString callSelected = RxString('한 번 진동');
  final RxString shoutSelected = RxString('한 번 진동');

  void updateCrySelected(String value) async{
    crySelected(value);
 final prefs = await SharedPreferences.getInstance();
    await prefs.setString("crying", value);
  }

  void updateCallSelected(String value) async{
    callSelected(value);
     final prefs = await SharedPreferences.getInstance();
    await prefs.setString("calling", value);
  }

  void updateShoutSelected(String value) async{
    shoutSelected(value);
       final prefs = await SharedPreferences.getInstance();
    await prefs.setString("shouting", value);
  }
}
