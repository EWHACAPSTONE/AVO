import 'dart:async';
import 'package:avo_front/controller/DropdownButtonController.dart';
import 'package:avo_front/controller/Notification_controller.dart';
import 'package:avo_front/pages/Home.dart';
import 'package:avo_front/pages/InformationPage.dart';
import 'package:avo_front/pages/SettingPage.dart';
import 'package:avo_front/utils/setting_notification.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  final snapshot =
      await firestore.collection('alarm').doc('3a1YFfhx4HPeTdPvAXjJ').get();
  SettingNotification.handleFirestoreSnapshot(snapshot, message);
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(scaffoldBackgroundColor: const Color(0xfff8f8f8)),
        title: 'AVO',
        initialBinding: BindingsBuilder(() {
          Get.put(DropdownButtonController());
          Get.put(NotificationController(), permanent: true);
        }),
        initialRoute: '/',
        getPages: [
          GetPage(name: '/', page: () => HomePage()),
          GetPage(name: '/setting', page: () => settingPage()),
          GetPage(name: '/info', page: () => informationPage()),
        ]);
  }
}
