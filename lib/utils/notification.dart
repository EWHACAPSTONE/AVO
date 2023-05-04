import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class FlutterLocalNotification{
  FlutterLocalNotification._();
  static FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static init() async {
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
}

  static requestNotificationPermission() {
    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );
  }

  static Future<void> showNotification(String situation) async {
    const AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails('channel id', 'channel name',
            channelDescription: 'channel description',
            importance: Importance.max,
            priority: Priority.max,
            showWhen: false);

    const NotificationDetails notificationDetails = NotificationDetails(
        android: androidNotificationDetails,
        iOS: DarwinNotificationDetails(badgeNumber: 1));
switch(situation){

  case "shouting":
      await flutterLocalNotificationsPlugin.show(
        0, 'AVO', '아이가 소리지르는게 감지됐어요!\n아이에게 한 번 가보세요.', notificationDetails);
        break;
  case "crying":
      await flutterLocalNotificationsPlugin.show(
        0, 'AVO', '아이가 울고 있는 소리가 감지됐어요!\n아이에게 한 번 가보세요.', notificationDetails);
  break;
    case "calling":
      await flutterLocalNotificationsPlugin.show(
        0, 'AVO', '아이가 부르는 소리가 감지됐어요!\n아이에게 한 번 가보세요.', notificationDetails);
  break;

}
    
  }
  
}