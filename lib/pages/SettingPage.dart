import 'package:flutter/material.dart';
import 'package:get/get.dart';

class settingPage extends StatefulWidget {
  @override
  State<settingPage> createState() => _settingPageState();
}

class _settingPageState extends State<settingPage> {
  final _options = ['한 번 진동', '두 번 진동', '세 번 진동', '연속 진동'];
  String _crySelected = '';
  String _callSelected = '';
  String _shoutSelected = '';

  @override
  void initState() {
    super.initState();
    setState(() {
      _crySelected = _options[0];
      _callSelected = _options[0];
      _shoutSelected = _options[0];
    });
  }

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;
    return Scaffold(
        body: Column(
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
            height: h * 0.55,
            child: Column(
              children: [
                SizedBox(height: 20),
                dropdownTitle("아이가 울어요"),
                Container(
                  width: w * 0.6,
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      color: Color.fromRGBO(255, 255, 255, 0.8),
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                            color: Color.fromRGBO(0, 0, 0, 0.25),
                            blurRadius: 5,
                            offset: Offset(0, 5),
                            spreadRadius: 0)
                      ]),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton(
                       iconSize: 50,
                      iconEnabledColor: Colors.black,
                      style: TextStyle(
                          fontFamily: 'NanumSquare',
                          fontSize: 20,
                          fontWeight: FontWeight.w800,
                          color: Colors.black),
                      dropdownColor: Color.fromRGBO(255, 255, 255, 0.9),
                      borderRadius: BorderRadius.circular(10),
                      value: _crySelected,
                      items: _options
                          .map(
                              (e) => DropdownMenuItem(value: e, child: Text(e)))
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          _crySelected = value!;
                        });
                      },
                    ),
                  ),
                ),
                dropdownTitle("아이가 불러요"),
                Container(
                  width: w * 0.6,
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      color: Color.fromRGBO(255, 255, 255, 0.8),
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                            color: Color.fromRGBO(0, 0, 0, 0.25),
                            blurRadius: 5,
                            offset: Offset(0, 5),
                            spreadRadius: 0)
                      ]),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton(
                      iconSize: 50,
                      iconEnabledColor: Colors.black,
                      style: TextStyle(
                          fontFamily: 'NanumSquare',
                          fontSize: 20,
                          fontWeight: FontWeight.w800,
                          color: Colors.black),
                      dropdownColor: Color.fromRGBO(255, 255, 255, 0.9),
                      borderRadius: BorderRadius.circular(10),
                      value: _callSelected,
                      items: _options
                          .map(
                              (e) => DropdownMenuItem(value: e, child: Text(e)))
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          _callSelected = value!;
                        });
                      },
                    ),
                  ),
                ),
                dropdownTitle("아이가 소리질러요"),
                Container(
                  width: w * 0.6,
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      color: Color.fromRGBO(255, 255, 255, 0.8),
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                            color: Color.fromRGBO(0, 0, 0, 0.25),
                            blurRadius: 5,
                            offset: Offset(0, 5),
                            spreadRadius: 0)
                      ]),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton(
                       iconSize: 50,
                      iconEnabledColor: Colors.black,
                      style: TextStyle(
                          fontFamily: 'NanumSquare',
                          fontSize: 20,
                          fontWeight: FontWeight.w800,
                          color: Colors.black),
                      dropdownColor: Color.fromRGBO(255, 255, 255, 0.9),
                      borderRadius: BorderRadius.circular(10),
                      value: _shoutSelected,
                      items: _options
                          .map(
                              (e) => DropdownMenuItem(value: e, child: Text(e)))
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          _shoutSelected = value!;
                        });
                      },
                    ),
                  ),
                )
              ],
            ))
      ],
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
