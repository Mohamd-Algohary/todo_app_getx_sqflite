import 'dart:io';
import 'package:flutter/material.dart';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:get/get.dart';
import 'package:rxdart/rxdart.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

import '../domain/model/task.dart';
import '../presentation/resources/routes_manager.dart';

class NotificationManager {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  String selectedNotificationPayload = '';

  final BehaviorSubject<String> selectNotificationSubject =
      BehaviorSubject<String>();

  //!----------------Initialize settings for Android and IOS-------------
  Future<void> initializeNotification() async {
    tz.initializeTimeZones();
    configureSelectNotificationSubject();
    await configureLocalTimeZone();
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('appicon');
    final DarwinInitializationSettings initializationSettingsDarwin =
        DarwinInitializationSettings(
            requestSoundPermission: false,
            requestBadgePermission: false,
            requestAlertPermission: false,
            onDidReceiveLocalNotification: onDidReceiveLocalNotification);
    final InitializationSettings initializationSettings =
        InitializationSettings(
            android: initializationSettingsAndroid,
            iOS: initializationSettingsDarwin);

    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse: onDidReceiveNotificationResponse);
  }

  //!----------------Get permission for Android and IOS-------------------
  void requestForPermission() {
    if (Platform.isIOS) {
      flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              IOSFlutterLocalNotificationsPlugin>()!
          .requestPermissions(
              sound: true, alert: true, badge: true, critical: true);
    } else {
      flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>()
          ?.requestPermission();
    }
  }

  //!-----------------Display notification for Android and IOS-------------
  void displayNotification(
      {required String title, required String body}) async {
    const AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails('your channel id', 'your channel name',
            channelDescription: 'your channel description',
            importance: Importance.max,
            priority: Priority.high,
            ticker: 'ticker');
    const DarwinNotificationDetails iosNotificationDetails =
        DarwinNotificationDetails();
    const NotificationDetails notificationDetails = NotificationDetails(
        android: androidNotificationDetails, iOS: iosNotificationDetails);

    await flutterLocalNotificationsPlugin
        .show(0, title, body, notificationDetails, payload: 'Default_Sound');
  }

  //!----------------Display schedule notification for Android and IOS---------
  void scheduledNotification(
      {required int hour, required int minutes, required Task task}) async {
    var notificationTime = timeZoneDT(hour, minutes, task);
    await flutterLocalNotificationsPlugin.zonedSchedule(
        task.id!,
        task.title,
        task.note,
        //tz.TZDateTime.now(tz.local).add(const Duration(seconds: 5)),
        notificationTime,
        const NotificationDetails(
          android: AndroidNotificationDetails(
              'your channel id', 'your channel name',
              channelDescription: 'your channel description',
              importance: Importance.max,
              priority: Priority.high,
              ticker: 'ticker'),
          iOS: DarwinNotificationDetails(),
        ),
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        matchDateTimeComponents: DateTimeComponents.time,
        payload: '${task.title}|${task.note}|${task.startTime}|');
  }

  //!------------------------set time of Schedule notification--------------------------
  tz.TZDateTime timeZoneDT(int hour, int minutes, Task task) {
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    var s = task.date!.split('-');
    var date = DateTime.parse('${s[2]}-${s[1]}-${s[0]}');
    final tz.TZDateTime taskTZ = tz.TZDateTime.from(date, tz.local);

    tz.TZDateTime scheduledDate = tz.TZDateTime(
            tz.local, taskTZ.year, taskTZ.month, taskTZ.day, hour, minutes)
        .subtract(Duration(minutes: task.remind!));

    if (scheduledDate.isBefore(now)) {
      if (task.repeat == 'Daily') {
        scheduledDate = scheduledDate.add(const Duration(days: 1));
      } else if (task.repeat == 'Weekly') {
        scheduledDate = tz.TZDateTime(tz.local, taskTZ.year, taskTZ.month,
                taskTZ.day + 7, hour, minutes)
            .subtract(Duration(minutes: task.remind!));
      } else if (task.repeat == 'Monthly') {
        scheduledDate = tz.TZDateTime(tz.local, taskTZ.year, taskTZ.month + 1,
                taskTZ.day, hour, minutes)
            .subtract(Duration(minutes: task.remind!));
      }
    }
    return scheduledDate;
  }

  //!-----------------------Select Notification Subject---------------------
  void configureSelectNotificationSubject() {
    selectNotificationSubject.stream.listen((String payload) async {
      await Get.toNamed(Routes.notification, arguments: payload);
    });
  }

  //!------------------------set local time zone-------------------------------
  Future<void> configureLocalTimeZone() async {
    final String timeZoneName = await FlutterNativeTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(timeZoneName));
  }

  //!----------------Response for Notification for Android and IOS-----------
  void onDidReceiveNotificationResponse(
      NotificationResponse notificationResponse) async {
    final String? payload = notificationResponse.payload;
    if (notificationResponse.payload != null) {
      return;
    }
    await Get.toNamed(Routes.notification, arguments: payload ?? '');
  }

  //!-------------Show dialog when receive a notification for old IOS---------
  void onDidReceiveLocalNotification(
      int id, String? title, String? body, String? payload) async {
    // display a dialog with the notification details, tap ok to go to another page
    Get.dialog(Text(body!));
  }

  //!------------------------cancel the notification---------------------
  void cancelNotification(Task task) async {
    await flutterLocalNotificationsPlugin.cancel(task.id!);
  }

  //!------------------------cancel all the notification---------------------
  void cancelAllNotification() async {
    await flutterLocalNotificationsPlugin.cancelAll();
  }
}
