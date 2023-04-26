import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class LocalNotificationService {
  final _notifications = FlutterLocalNotificationsPlugin();

  Future _notificationDetails() async {
    const BigTextStyleInformation bigTextStyleInformation = BigTextStyleInformation(
      "",
      htmlFormatBigText: true,
      htmlFormatContentTitle: true,
      htmlFormatSummaryText: true,
    );
    const AndroidNotificationDetails androidNotificationDetails = AndroidNotificationDetails(
      'channel id',
      'channel name',
      channelDescription: 'big text channel description',
      styleInformation: bigTextStyleInformation,
      importance: Importance.max,
      playSound: true,
      priority: Priority.max,
      fullScreenIntent: true,
      visibility: NotificationVisibility.public,
    );

    return const NotificationDetails(android: androidNotificationDetails, iOS: DarwinNotificationDetails());
  }

  Future init({bool initScheduled = false}) async {
    const android = AndroidInitializationSettings('launch_background');
    final iOS = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestCriticalPermission: true,
      requestSoundPermission: true,
      notificationCategories: [
        // ignore: prefer_const_constructors
        DarwinNotificationCategory(
          'demoCategory',
          actions: <DarwinNotificationAction>[],
          options: <DarwinNotificationCategoryOption>{
            DarwinNotificationCategoryOption.allowAnnouncement,
            DarwinNotificationCategoryOption.hiddenPreviewShowTitle,
          },
        ),
      ],
      onDidReceiveLocalNotification: (id, title, body, payload) {},
    );
    final settings = InitializationSettings(android: android, iOS: iOS);
    await _notifications.initialize(
      settings,
      onDidReceiveNotificationResponse: (details) async {
        if (details.payload != null) {}
      },
    );
  }

  Future showNotification({
    required int id,
    required String title,
    required String? body,
    required String? payload,
  }) async {
    final details = await _notificationDetails();
    await _notifications.show(
      id,
      title,
      body,
      details,
      payload: payload,
    );
  }
}
