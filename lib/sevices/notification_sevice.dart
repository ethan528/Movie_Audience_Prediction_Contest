import 'dart:convert';

import 'package:fcm/main.dart';
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
        'ya29.c.c0ASRK0GYGGk3313PYRxJNGN-NHK6EbxsYfoewEz9jdPm6AebDOL7Kvhy_1aVeEkU09E4qRnid72_To4ROdBcXRqgXY0FMJbVQur3a4uQYpK-Cf3LHLAoNqgPTAAco3NdVsRuPw3N8hILCZqBLUrQA81iDnuyjJ5PgtYO4vhOUapCkX4U9rE4snntD_xOLNQAaeFroNmYn-QCPYyAdWSHBU-LoFoEB_T8NbuNJSHIkgsNN3h9kQsgAlv4APeejiWas3Z-67YrAmW1ck7Ng0ofTyphYmEXvTncjVSQl5C85MlDMQSoqBJCl-PYulaWVbfE6uHWe04r3Fw5fLtoSgAcfO1rb3oyDbwVxO0n1LD8aL99Wjrw3SSU9AgE383CufXF7pi34xb-VmXehiWyIgjUXJtk-IMjhM2itSiRu53jUuQ_txV4zQFR3Iw43Bt_bIZsz_QUspRqdtZFzc57m6UvS0uqQuZW91pW12Indj2iFVIf493hqywyJ6r5cuQZzMm_Zyf8W5OzMVo_Z4BcZ-xgjy52MY2cs-fmh0M0mfm2ieXjlQhoF2e6smbVp3BMrXFcSyBQxQ33pp-6tJjghlulb5y-sRjOihpfXlV7uaaWjpYuvi25iUdugxohu1OFRfw5OuUkJ3hghSYRrrxxRWFSSYm57ry4RqBhIY6_d3t9XSVsXzy4-t8_uWJvVa-1ku7VdbWBoWudf4dxqvsfg3edVSx4xeaeptWFVulVqXmrMI7J2isSROsMbj0opZaiv_Q9mvYcSXvz1Zz0v0iiYI2ftw9nMJMt_FU7_aO60lgvuInrcFU_tyaJQwhgUtXrjo0p9k7kq7XJk_bRhgfVmqvbRVfeqZ8J7jZXdVrcn-gwWcWw_pxprSReZrtIn8kyRdBxw852M8eoQ6JmMk8RdOOjvr8zSu3g2r4xddtcFm2pSuUS0tdJbWpIBl4iwp72MX0V0rXaU_sj30RwXQ1iZ94-dqsRUU_zFn-v6Zw08mfndiFqqY6dm2OqJhWb';
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
}
