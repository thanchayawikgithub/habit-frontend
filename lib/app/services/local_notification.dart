import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:rxdart/rxdart.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class LocalNotifications {
  static final FlutterLocalNotificationsPlugin
      _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  static final onClickNotification = BehaviorSubject<String>();

// on tap on any notification
  static void onNotificationTap(NotificationResponse notificationResponse) {
    onClickNotification.add(notificationResponse.payload!);
  }

// initialize the local notifications
  static Future init() async {
    // initialise the plugin. app_icon needs to be a added as a drawable resource to the Android head project
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    final DarwinInitializationSettings initializationSettingsDarwin =
        DarwinInitializationSettings(
      onDidReceiveLocalNotification: (id, title, body, payload) => null,
    );
    final LinuxInitializationSettings initializationSettingsLinux =
        LinuxInitializationSettings(defaultActionName: 'Open notification');
    final InitializationSettings initializationSettings =
        InitializationSettings(
            android: initializationSettingsAndroid,
            iOS: initializationSettingsDarwin,
            linux: initializationSettingsLinux);

    // request notification permissions
    _flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()!
        .requestNotificationsPermission();

    _flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse: onNotificationTap,
        onDidReceiveBackgroundNotificationResponse: onNotificationTap);
  }

  // show a simple notification
  static Future showSimpleNotification({
    required String title,
    required String body,
    required String payload,
  }) async {
    const AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails('your channel id', 'your channel name',
            channelDescription: 'your channel description',
            importance: Importance.max,
            priority: Priority.high,
            ticker: 'ticker');
    const NotificationDetails notificationDetails =
        NotificationDetails(android: androidNotificationDetails);
    await _flutterLocalNotificationsPlugin
        .show(0, title, body, notificationDetails, payload: payload);
  }

  // to show periodic notification at regular interval
  static Future showPeriodicNotifications({
    required String title,
    required String body,
    required String payload,
  }) async {
    const AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails('channel 2', 'your channel name',
            channelDescription: 'your channel description',
            importance: Importance.max,
            priority: Priority.high,
            ticker: 'ticker');
    const NotificationDetails notificationDetails =
        NotificationDetails(android: androidNotificationDetails);
    await _flutterLocalNotificationsPlugin.periodicallyShow(
        1, title, body, RepeatInterval.everyMinute, notificationDetails,
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        payload: payload);
  }

  // to schedule a local notification
  // static Future showScheduleNotification({
  //   required String title,
  //   required String body,
  //   required String payload,
  // }) async {
  //   tz.initializeTimeZones();
  //   await _flutterLocalNotificationsPlugin.zonedSchedule(
  //       2,
  //       title,
  //       body,
  //       tz.TZDateTime.now(tz.local).add(const Duration(seconds: 5)),
  //       const NotificationDetails(
  //           android: AndroidNotificationDetails(
  //               'channel 3', 'your channel name',
  //               channelDescription: 'your channel description',
  //               importance: Importance.max,
  //               priority: Priority.high,
  //               ticker: 'ticker')),
  //       androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
  //       uiLocalNotificationDateInterpretation:
  //           UILocalNotificationDateInterpretation.absoluteTime,
  //       payload: payload);
  // }

  // static Future<void> showScheduleNotification({
  //   required String title,
  //   required String body,
  //   required String payload,
  //   required String date, // Add date parameter
  //   required String time, // Add time parameter
  // }) async {
  //   print('register notification at : $date $time');
  //   tz.initializeTimeZones();

  //   // Parse the date and time
  //   DateTime scheduledDateTime = DateTime.parse('$date $time');

  //   await _flutterLocalNotificationsPlugin.zonedSchedule(
  //     2,
  //     title,
  //     body,
  //     tz.TZDateTime.from(scheduledDateTime, tz.local),
  //     const NotificationDetails(
  //       android: AndroidNotificationDetails(
  //         'channel 3',
  //         'your channel name',
  //         channelDescription: 'your channel description',
  //         importance: Importance.max,
  //         priority: Priority.high,
  //         ticker: 'ticker',
  //       ),
  //     ),
  //     androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
  //     uiLocalNotificationDateInterpretation:
  //         UILocalNotificationDateInterpretation.absoluteTime,
  //     payload: payload,
  //   );
  // }

  // static Future<void> showScheduleNotification({
  //   required String title,
  //   required String body,
  //   required String payload,
  //   required String date, // Add date parameter
  //   required String time, // Add time parameter
  // }) async {
  //   print('Register notification at: $date $time');
  //   tz.initializeTimeZones();

  //   // Parse the date and time
  //   DateTime scheduledDateTime = DateTime.parse('$date $time');

  //   // Request notification permissions
  //   if (await _requestNotificationPermission()) {
  //     await _flutterLocalNotificationsPlugin.zonedSchedule(
  //       2,
  //       title,
  //       body,
  //       tz.TZDateTime.from(scheduledDateTime, tz.local),
  //       const NotificationDetails(
  //         android: AndroidNotificationDetails(
  //           'channel 3',
  //           'your channel name',
  //           channelDescription: 'your channel description',
  //           importance: Importance.max,
  //           priority: Priority.high,
  //           ticker: 'ticker',
  //         ),
  //       ),
  //       androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
  //       uiLocalNotificationDateInterpretation:
  //           UILocalNotificationDateInterpretation.absoluteTime,
  //       payload: payload,
  //     );
  //   } else {
  //     print('Notification permission denied.');
  //   }
  // }

  static Future<void> showScheduleNotification({
    required String title,
    required String body,
    required String payload,
    required String date,
    required String time,
  }) async {
    print('Register notification at: $date $time');
    tz.initializeTimeZones();

    // Parse the date and time
    DateTime scheduledDateTime = DateTime.parse('$date $time');

    // Request notification permissions
    if (await _requestNotificationPermission()) {
      // Request exact alarm permission for Android 12+
      if (await _requestExactAlarmPermission()) {
        await _flutterLocalNotificationsPlugin.zonedSchedule(
          2,
          title,
          body,
          tz.TZDateTime.from(scheduledDateTime, tz.local),
          const NotificationDetails(
            android: AndroidNotificationDetails(
              'channel 3',
              'your channel name',
              channelDescription: 'your channel description',
              importance: Importance.max,
              priority: Priority.high,
              ticker: 'ticker',
            ),
          ),
          androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
          uiLocalNotificationDateInterpretation:
              UILocalNotificationDateInterpretation.absoluteTime,
          payload: payload,
        );
      } else {
        print('Exact alarm permission denied.');
      }
    } else {
      print('Notification permission denied.');
    }
  }

// Function to check and request notification permission
  static Future<bool> _requestNotificationPermission() async {
    final status = await Permission.notification.status;
    if (status.isDenied) {
      await Permission.notification.request();
    }
    return await Permission.notification.isGranted;
  }

// Function to check and request exact alarm permission for Android 12+
  static Future<bool> _requestExactAlarmPermission() async {
    if (Platform.isAndroid && (await _getAndroidSdkVersion()) >= 31) {
      try {
        // Check if exact alarms are allowed
        const MethodChannel platform =
            MethodChannel('flutter_local_notifications');
        final bool result =
            await platform.invokeMethod('areExactAlarmsPermitted');
        if (!result) {
          // Request permission to use exact alarms
          await platform.invokeMethod('requestExactAlarmPermission');
        }
        return result;
      } on PlatformException catch (e) {
        print('Failed to check exact alarm permission: ${e.message}');
        return false;
      }
    }
    return true;
  }

// Helper function to get Android SDK version
  static Future<int> _getAndroidSdkVersion() async {
    const MethodChannel platform = MethodChannel('flutter_local_notifications');
    return await platform.invokeMethod('getAndroidSdkVersion');
  }

// Function to check and request notification permission
  // static Future<bool> _requestNotificationPermission() async {
  //   final status = await Permission.notification.status;
  //   if (status.isDenied) {
  //     // Request permission
  //     await Permission.notification.request();
  //   }
  //   return await Permission.notification.isGranted;
  // }

  // // close a specific channel notification
  // static Future cancel(int id) async {
  //   await _flutterLocalNotificationsPlugin.cancel(id);
  // }

  // // close all the notifications available
  // static Future cancelAll() async {
  //   await _flutterLocalNotificationsPlugin.cancelAll();
  // }
}
