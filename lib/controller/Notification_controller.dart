import 'package:avo_front/controller/DropdownButtonController.dart';
import 'package:avo_front/utils/setting_notification.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
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
      // ignore: empty_catches
    } catch (e) {}
  }

  final AndroidNotificationChannel channel = const AndroidNotificationChannel(
    'high_importance_channel',
    'High Importance Notifications',
    description: 'This channel is used for important notifications.',
    importance: Importance.max,
  );

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  void _onMessage() async {
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    AndroidInitializationSettings androidInitializationSettings =
        const AndroidInitializationSettings('mipmap/ic_launcher');

    DarwinInitializationSettings iosInitializationSettings =
        const DarwinInitializationSettings(
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
      await Firebase.initializeApp();
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      final snapshot =
          await firestore.collection('alarm').doc('3a1YFfhx4HPeTdPvAXjJ').get();
      SettingNotification.handleFirestoreSnapshot(snapshot, message);
    });
  }
}
