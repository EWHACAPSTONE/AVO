import 'package:get/get.dart';


class DropdownButtonController extends GetxController {
  final RxString crySelected = RxString('한 번 진동');
  final RxString callSelected = RxString('한 번 진동');
  final RxString shoutSelected = RxString('한 번 진동');

  void updateCrySelected(String value) {
    crySelected(value);
  }

  void updateCallSelected(String value) {
    callSelected(value);
  }

  void updateShoutSelected(String value) {
    shoutSelected(value);
  }
}
