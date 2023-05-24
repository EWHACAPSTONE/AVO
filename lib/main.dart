import 'dart:async';
import 'dart:math';
import 'package:avo_front/controller/DropdownButtonController.dart';
import 'package:avo_front/controller/Notification_controller.dart';
import 'package:avo_front/pages/Home.dart';
import 'package:avo_front/pages/InformationPage.dart';
import 'package:avo_front/pages/SettingPage.dart';
import 'package:avo_front/utils/setting_vibration.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get_storage/get_storage.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
   final prefs = await SharedPreferences.getInstance();
    

 if (message.notification != null){
  final controller = Get.put(DropdownButtonController());
  String notificationText;
  switch (message.notification!.body) {
    case 'shouting':
      notificationText = '아이가 소리지르는게 감지됐어요!\n아이에게 한 번 가보세요.';
      SettingVibration.setVibrate(prefs.getString("shouging")??'한 번 진동');
      break;

    case 'crying':
      notificationText = '아이가 울고 있는 소리가 감지됐어요!\n아이에게 한 번 가보세요.';
      SettingVibration.setVibrate(prefs.getString("crying")??'한 번 진동');
      break;

    case 'calling':
      notificationText = '아이가 부르는 소리가 감지됐어요!\n아이에게 한 번 가보세요.';
      SettingVibration.setVibrate(prefs.getString("calling")??'한 번 진동');
      break;

    default:
      notificationText = '새로운 알림이 도착했습니다.';
  
  }

  final AndroidNotificationChannel channel = const AndroidNotificationChannel(
    'high_importance_channel',
    'High Importance Notifications',
    description: 'This channel is used for important notifications.',
    importance: Importance.max,
  );
    const AndroidNotificationDetails androidNotificationDetails = AndroidNotificationDetails(
    'high_importance_channel',
    'High Importance Notifications',
    channelDescription: 'This channel is used for important notifications.',
  );

  const NotificationDetails notificationDetails = NotificationDetails(
    android: androidNotificationDetails,
  );

  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  await flutterLocalNotificationsPlugin.show(
    Random().nextInt(100),
    'AVO',
    notificationText,
    notificationDetails,
  );

  print('백그라운드에서 메시지를 받았습니다: ${message.notification!.body}');
  print('Message data: ${message.data}');
}
}


Future<void> initializeDefault() async {
 FirebaseApp app = await Firebase.initializeApp();
  print('Initialized default app');

}


Future<void> main() async {
  
  await GetStorage.init();
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDefault();
  
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
