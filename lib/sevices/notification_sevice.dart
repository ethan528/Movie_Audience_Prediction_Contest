import 'dart:convert';

import 'package:flutter_fcm/main.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart' as http;

import '../chat_screen.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await NotificationService.instance.setupFlutterNotifications();
  await NotificationService.instance.showNotification(message);
}

class NotificationService {
  NotificationService._();

  static final NotificationService instance = NotificationService._();

  final _messaging = FirebaseMessaging.instance;
  final _localNotifications = FlutterLocalNotificationsPlugin();
  bool _isFlutterLocalNotificationsInitialized = false;

  Future<void> initialize() async {
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    // Request permission
    await _requestPermission();

    // Setup message handlers
    await _setupMessageHandlers();
    await setupFlutterNotifications();

    // Get FCM token
    final token = await _messaging.getToken();
    print('FCM Token: $token');

    // subscribe to all devices/broadcast
    subscribeToTopic('all_devices');
  }

  Future<void> _requestPermission() async {
    final settings = await _messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
      provisional: false,
      announcement: false,
      carPlay: false,
      criticalAlert: false,
    );

    print('Permission status: ${settings.authorizationStatus}');
  }

  Future<void> setupFlutterNotifications() async {
    if (_isFlutterLocalNotificationsInitialized) {
      return;
    }

    // android setup
    const channel = AndroidNotificationChannel(
      'high_importance_channel',
      'High Importance Notifications',
      description: 'This channel is used for important notifications.',
      importance: Importance.high,
    );

    await _localNotifications
        .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    const initializationSettingsAndroid =
    AndroidInitializationSettings('@mipmap/ic_launcher');

    // ios setup
    const initializationSettingsDarwin = DarwinInitializationSettings();

    const initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsDarwin,
    );

    // flutter notification setup
    await _localNotifications.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (NotificationResponse details) =>
          _handleBackgroundMessage(details.payload!),
    );

    _isFlutterLocalNotificationsInitialized = true;
  }

  Future<void> showNotification(RemoteMessage message) async {
    RemoteNotification? remoteNotification = message.notification;
    AndroidNotification? androidNotification = message.notification?.android;

    if (remoteNotification != null && androidNotification != null) {
      await _localNotifications.show(
        remoteNotification.hashCode,
        remoteNotification.title,
        remoteNotification.body,
        const NotificationDetails(
          android: AndroidNotificationDetails(
            'high_importance_channel',
            'High Importance Notifications',
            channelDescription:
            'This channel is used for important notifications.',
            importance: Importance.high,
            priority: Priority.high,
            icon: '@mipmap/ic_launcher',
          ),
          iOS: DarwinNotificationDetails(
            presentAlert: true,
            presentBadge: true,
            presentSound: true,
          ),
        ),
        payload: message.data['type'].toString(),
      );
    }
  }

  Future<void> _setupMessageHandlers() async {
    // foreground message
    FirebaseMessaging.onMessage.listen((message) {
      showNotification(message);
      _showDialogWithNotification(message);
    });

    // background message
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      _handleBackgroundMessage(message.data['type']);
    });

    // opened app
    final initialMessage = await _messaging.getInitialMessage();
    if (initialMessage != null) {
      _handleBackgroundMessage(initialMessage.data['type']);
    }
  }

  void _handleBackgroundMessage(String message) {
    if (message == 'chat') {
      // open chat screen
      navigatorKey.currentState?.push(MaterialPageRoute(
        builder: (context) => const ChatScreen(),
      ));
    }
  }

  Future<void> subscribeToTopic(String topic) async {
    await FirebaseMessaging.instance.subscribeToTopic(topic);
    print('Subscribed to $topic');
  }

  Future<void> sendNotification(String title, String body) async {
    String accessToken =
        'ya29.c.c0ASRK0GYi-zT4pLNFT5-A7tSyZzSYdcnQBVmIkQBtwtoX6l8MoGl8v1YWjrAM0X3k-297HyKR4HVxajm934ZKUilWFLRmmH0CgDcv9fKyruIjqxYZwfDNnjOYLBRa4z6InCJ-JJnPClCB_3dyI_-tQh5TGsm9aAnPGEA5mX5v6wWYSWBRfAtYQJHEAPdiWBAEzT5Vu6fRAD7wF65yxcDFGLBva876KA4fsv9MtfBveuzNZPyqCCTqOKGOYeZYawe6dvWm_14TpP-PYwJ__c5W7jzqJV21bgUFxxibd08jizTQPnNot0i7iXh8AAJQizdeMOIJjhucRAlTkXXk5mmnrQqditL7JP-k2kxR-hmPc5g_UOBLqw9WSsMT384Pjrkl-Ro-1OSf4dcMZl8364B1pXk25ubBwlmWVVfM1ejq5uw0pUc6vRIVVibtl4bmtpu8lJUtohxwUJlmy3ppSS5dOcURlM582qku34lqkRx6UcmcrYaQd3964c8OcVOhr7B3ffQ8UvQxQ4Ws4tSV_7p724MO6oYrv9nxlM06uIp-vgVQB6hteb88zvQyyBRx_XZr2rm4qunrb7xz0V0Mecqiv3x4MOVVbauW2pUOUOydj8jimuBow0qyaIQjmXyo22w4UuckXnp80ZRB4YSqQk9q44Wa270WwlFImkkqg0RB-Xqqz-grVWriMd-tbj-Xc3ayofMpI_VsJxcuWiB33scuBUUUiZwZt60-td9nnzS26Wxy1Ricq2SqpZkBFu28Vslx21rntnm6MQRZhtsndOe-tai4S9jr-OarBQkrBq-sh3uQu03V98zU53frqjZrOlY8Scjimqvbwqnp06x-cIwnyRycR400vebk-n4jOrcZ-vIfdUrxZZB0e_j8UZscSFesx0f57F8R67deQbsccx77yy1wiOr7QYQQ87MS7MJ0mzQdvhvanbsfRVQ40shngRRrelgvSRwh36u_vZpfj03iMBZS9yYWtjFomawS7f3wVe5nshSi5q27-BX';
    var messagePayload = {
      'message': {
        'topic': 'all_devices',
        'notification': {
          'title': title,
          'body': body,
        },
        'data': {'type': 'chat'},
        'android': {
          'priority': 'high',
          'notification': {'channel_id': 'high_importance_channel'},
        }
      }
    };
    final url =
        'https://fcm.googleapis.com/v1/projects/fcm-test-9609c/messages:send';
    final headers = {
      'Authorization': 'Bearer $accessToken',
      'Content-Type': 'application/json'
    };

    final response = await http.post(
      Uri.parse(url),
      headers: headers,
      body: jsonEncode(messagePayload),
    );

    if (response.statusCode == 200) {
      print('Notification sent successfully');
    } else {
      print('Error sending notification: ${response.body}');
    }
  }

  void _showDialogWithNotification(RemoteMessage message) {
    final context = navigatorKey.currentContext;

    if (context != null) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(message.notification?.title ?? 'Notification'),
            content:
            Text(message.notification?.body ?? 'You Have a new message'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Close'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  _handleBackgroundMessage(message.data['type'] ?? '');
                },
                child: const Text('View'),
              ),
            ],
          );
        },
      );
    }
  }
}
