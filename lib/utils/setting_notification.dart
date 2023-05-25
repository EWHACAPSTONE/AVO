import 'dart:math';
import 'package:avo_front/utils/setting_vibration.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

class SettingNotification {
  static Future<void> handleFirestoreSnapshot(
      DocumentSnapshot snapshot, RemoteMessage message) async {
    if (snapshot.data() != null) {
      // Firestore에서 변경된 데이터를 사용합니다.
      var firestoreData = snapshot.data() as Map<String, dynamic>;
      // calling, crying, shouting 값을 가져옵니다.
      var callingValue = firestoreData['calling']!;
      var cryingValue = firestoreData['crying']!;
      var shoutingValue = firestoreData['shouting']!;
      // 알림 및 진동 설정
      if (message.notification != null) {
        String notificationText;
        switch (message.notification!.body) {
          case 'shouting':
            notificationText = '아이가 소리지르는게 감지됐어요!\n아이에게 한 번 가보세요.';
            SettingVibration.setVibrate(shoutingValue);
            break;
          case 'crying':
            notificationText = '아이가 울고 있는 소리가 감지됐어요!\n아이에게 한 번 가보세요.';
            SettingVibration.setVibrate(cryingValue);
            break;
          case 'calling':
            notificationText = '아이가 부르는 소리가 감지됐어요!\n아이에게 한 번 가보세요.';
            SettingVibration.setVibrate(callingValue);
            break;
          default:
            notificationText = '새로운 알림이 도착했습니다.';
        }

        final AndroidNotificationChannel channel =
            const AndroidNotificationChannel(
          'high_importance_channel',
          'High Importance Notifications',
          description: 'This channel is used for important notifications.',
          importance: Importance.max,
        );
        const AndroidNotificationDetails androidNotificationDetails =
            AndroidNotificationDetails(
          'high_importance_channel',
          'High Importance Notifications',
          channelDescription:
              'This channel is used for important notifications.',
        );

        const NotificationDetails notificationDetails = NotificationDetails(
          android: androidNotificationDetails,
        );
        await flutterLocalNotificationsPlugin
            .resolvePlatformSpecificImplementation<
                AndroidFlutterLocalNotificationsPlugin>()
            ?.createNotificationChannel(channel);
        await flutterLocalNotificationsPlugin.show(
          Random().nextInt(100),
          'AVO',
          notificationText,
          notificationDetails,
        );
      }
    }
  }
}
