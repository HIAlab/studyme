import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:studyme/models/task/task.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class Notifications {
  static Notifications? _instance;
  Notifications._();
  late FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin;

  static Future<void> init() async {
    final notifications = Notifications._();
    await notifications._load();
    _instance = notifications;
  }

  Future<void> _load() async {
    _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    await _initialize();
    await _configureLocalTimeZone();
  }

  factory Notifications() {
    if (_instance == null) {
      throw Exception('Notifications not initialized');
    }
    return _instance!;
  }

  Future<void> _configureLocalTimeZone() async {
    tz.initializeTimeZones();
    final String timeZoneName = await FlutterTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(timeZoneName));
  }

  Future<void> _initialize() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    final DarwinInitializationSettings initializationSettingsDarwin =
        DarwinInitializationSettings();

    InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsDarwin,
    );
    await _flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse: onDidReceiveNotificationResponse);
  }

  void onDidReceiveLocalNotification(
      int id, String? title, String? body, String? payload) {
    onDidReceiveNotificationResponse(NotificationResponse(
        notificationResponseType: NotificationResponseType.selectedNotification,
        id: id,
        payload: payload));
  }

  void onDidReceiveNotificationResponse(NotificationResponse details) async {
    // todo: implement
  }

  Future<void> scheduleNotificationFor(
      DateTime date, Task reminder, int id) async {
    tz.TZDateTime scheduledTime = _getScheduledTime(date, reminder.time!);
    tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    if (!scheduledTime.isBefore(now)) {
      const AndroidNotificationDetails androidNotificationDetails =
          AndroidNotificationDetails('studyme_app', 'StudyMe',
              channelDescription: 'StudyMe notifications',
              importance: Importance.max,
              priority: Priority.high,
              ticker: 'ticker');
      const NotificationDetails notificationDetails =
          NotificationDetails(android: androidNotificationDetails);
      await _flutterLocalNotificationsPlugin.zonedSchedule(
        id,
        'Time for your experiment',
        reminder.title,
        scheduledTime,
        notificationDetails,
        androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
      );
      print(
          'Scheduled notification $id, ${reminder.title}, $scheduledTime in ${scheduledTime.difference(now).inMinutes} min');
    }
  }

  tz.TZDateTime _getScheduledTime(DateTime date, TimeOfDay time) {
    tz.TZDateTime scheduledDate = tz.TZDateTime(
        tz.local, date.year, date.month, date.day, time.hour, time.minute);
    return scheduledDate;
  }

  Future<bool?>? requestPermission() {
    return _flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.requestNotificationsPermission();
  }

  Future<void> debugShowPendingRequests() async {
    final List<PendingNotificationRequest> pendingNotificationRequests =
        await _flutterLocalNotificationsPlugin.pendingNotificationRequests();

    if (pendingNotificationRequests.isNotEmpty) {
      for (var element in pendingNotificationRequests) {
        print(element.id);
        print(element.title);
      }
    } else {
      print('No pending notifications');
    }
  }

  Future<void> clearAll() async {
    _flutterLocalNotificationsPlugin.cancelAll();
  }
}
