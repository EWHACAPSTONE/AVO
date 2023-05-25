import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class DropdownButtonController extends GetxService {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  final RxString crySelected = RxString('');
  final RxString callSelected = RxString('');
  final RxString shoutSelected = RxString('');

  DropdownButtonController() {
    getCrySelectedValue().then((value) {
      crySelected.value = value;
    });
    getShoutSelectedValue().then((value) {
      shoutSelected.value = value;
    });
    getCallSelectedValue().then((value) {
      callSelected.value = value;
    });
  }

  void updateCrySelected(String value) async {
    crySelected(value);
    firestore
        .collection("alarm")
        .doc('3a1YFfhx4HPeTdPvAXjJ')
        .update({"crying": value});
  }

  void updateCallSelected(String value) async {
    callSelected(value);
    firestore
        .collection("alarm")
        .doc('3a1YFfhx4HPeTdPvAXjJ')
        .update({"calling": value});
  }

  void updateShoutSelected(String value) async {
    shoutSelected(value);
    firestore
        .collection("alarm")
        .doc('3a1YFfhx4HPeTdPvAXjJ')
        .update({"shouting": value});
  }

  Future<String> getCrySelectedValue() async {
    DocumentSnapshot snapshot =
        await firestore.collection("alarm").doc('3a1YFfhx4HPeTdPvAXjJ').get();
    Map<String, dynamic>? data = snapshot.data() as Map<String, dynamic>?;
    String cryValue = data?['crying'] ?? '한 번 진동';
    return cryValue;
  }

  Future<String> getCallSelectedValue() async {
    DocumentSnapshot snapshot =
        await firestore.collection("alarm").doc('3a1YFfhx4HPeTdPvAXjJ').get();
    Map<String, dynamic>? data = snapshot.data() as Map<String, dynamic>?;
    String callValue = data?['calling'] ?? '한 번 진동';
    return callValue;
  }

  Future<String> getShoutSelectedValue() async {
    DocumentSnapshot snapshot =
        await firestore.collection("alarm").doc('3a1YFfhx4HPeTdPvAXjJ').get();
    Map<String, dynamic>? data = snapshot.data() as Map<String, dynamic>?;
    String shoutValue = data?['shouting'] ?? '한 번 진동';
    return shoutValue;
  }
}
