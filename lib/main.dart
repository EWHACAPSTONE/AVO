import 'package:avo_front/controller/DropdownButtonController.dart';
import 'package:avo_front/pages/Home.dart';
import 'package:avo_front/pages/InformationPage.dart';
import 'package:avo_front/pages/SettingPage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() =>runApp(const MyApp());

class MyApp extends StatelessWidget {

  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(scaffoldBackgroundColor:const Color(0xfff8f8f8)),
      title: 'AVO',
      initialBinding: BindingsBuilder(() {
        Get.put(DropdownButtonController());
      }),
      initialRoute: '/',
      getPages:[
        GetPage(name: '/', page:()=> HomePage()),
        GetPage(name: '/setting', page:()=> settingPage()),
        GetPage(name: '/info', page:()=> informationPage()),

      ]
    );
  }
}




