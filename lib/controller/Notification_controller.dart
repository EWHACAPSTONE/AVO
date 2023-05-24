import 'package:avo_front/controller/DropdownButtonController.dart';
import 'package:avo_front/utils/setting_vibration.dart';
import 'package:get/get.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';



class NotificationController extends GetxController {

  
  FirebaseMessaging messaging = FirebaseMessaging.instance;


  @override
  void onInit() async {
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );


    _getToken();
    _onMessage();
    super.onInit();
  }

  void _getToken() async {
    try {
      String? token = await messaging.getToken();
      print("토큰 : $token");
    } catch (e) {
      print("에러");
    }
  }

  final AndroidNotificationChannel channel = const AndroidNotificationChannel(
    'high_importance_channel',
    'High Importance Notifications',
    description: 'This channel is used for important notifications.',
    importance: Importance.max,
  );

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();


  void _onMessage() async {
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    AndroidInitializationSettings androidInitializationSettings = const AndroidInitializationSettings('mipmap/ic_launcher');

    DarwinInitializationSettings iosInitializationSettings = const DarwinInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
    );

    InitializationSettings initializationSettings = InitializationSettings(
      android: androidInitializationSettings,
      iOS: iosInitializationSettings,
    );

    await flutterLocalNotificationsPlugin.initialize(initializationSettings);

    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      final controller = Get.put(DropdownButtonController());
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      print(message.notification);
      
      if (notification != null && android != null) {
        var situation = message.notification!.body;
        switch (situation) {
          case "shouting":
            await flutterLocalNotificationsPlugin.show(
              0,
              'AVO',
              '아이가 소리지르는게 감지됐어요!\n아이에게 한 번 가보세요.',
              NotificationDetails(
                android: AndroidNotificationDetails(channel.id, channel.name, channelDescription: channel.description),
              ),
            );
            SettingVibration.setVibrate(controller.shoutSelected.value);
            break;
          case "crying":
            await flutterLocalNotificationsPlugin.show(
              0,
              'AVO',
              '아이가 울고 있는 소리가 감지됐어요!\n아이에게 한 번 가보세요.',
              NotificationDetails(
                android: AndroidNotificationDetails(channel.id, channel.name, channelDescription: channel.description),
              ),
            );
            SettingVibration.setVibrate(controller.crySelected.value);
            break;
          case "calling":
            await flutterLocalNotificationsPlugin.show(
              0,
              'AVO',
              '아이가 부르는 소리가 감지됐어요!\n아이에게 한 번 가보세요.',
              NotificationDetails(
                android: AndroidNotificationDetails(channel.id, channel.name, channelDescription: channel.description),
              ),
            );
            SettingVibration.setVibrate(controller.callSelected.value);
            break;
        }
      }
      
      print('foreground 상황에서 메시지를 받았다.');
      print('Message data: ${message.data}');
      if (message.notification != null) {
        print('Message also contained a notification: ${message.notification!.body}');
      }
    });
  }
}
