import 'package:avo_front/controller/DropdownButtonController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../utils/DropdownButtonWidget.dart';

class settingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(DropdownButtonController());
    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        children: [
          Container(
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.fromLTRB(15, 35, 0, 0),
              child: IconButton(
                onPressed: () {
                  Get.toNamed('/');
                },
                icon: Image(image: AssetImage('images/icons/back.png')),
              ),
              height: 40),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                  alignment: Alignment.topLeft,
                  margin: EdgeInsets.only(left: 10),
                  child: Image(
                      image: AssetImage('images/logo.png'), width: w * 0.3)),
              Text(
                "알림 설정",
                style: TextStyle(fontSize: 20),
              )
            ],
          ),
          Image(image: (AssetImage('images/avo_4.png')), width: w * 0.9),
          Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Color(0xffBAD7B3),
              ),
              width: w * 0.9,
              height: h * 0.6,
              child: Column(
                children: [
                  SizedBox(height: 20),
                  dropdownTitle("아이가 울어요"),
                  Obx(() => DropdownButtonWidget(
                      selectedValue: controller.crySelected.value,
                      onChanged: (value) =>
                          controller.updateCrySelected(value!))),
                  dropdownTitle("아이가 불러요"),
                  Obx(
                    () => DropdownButtonWidget(
                        selectedValue: controller.callSelected.value,
                        onChanged: (value) =>
                            controller.updateCallSelected(value!)),
                  ),
                  dropdownTitle("아이가 소리질러요"),
                  Obx(() => DropdownButtonWidget(
                      selectedValue: controller.shoutSelected.value,
                      onChanged: (value) =>
                          controller.updateShoutSelected(value!))),
                ],
              ))
        ],
      ),
    ));
  }

  Container dropdownTitle(String title) {
    return Container(
        padding: EdgeInsets.fromLTRB(30, 28, 0, 15),
        alignment: Alignment.topLeft,
        child: Text(
          title,
          style: TextStyle(
              fontFamily: 'NanumSquare',
              fontSize: 22,
              fontWeight: FontWeight.bold),
        ));
  }
}
