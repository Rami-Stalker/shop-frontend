import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:shop_app/app/modules/auth/controllers/auth_controller.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

Future<void> handleBackgroundMessage(RemoteMessage message) async {
  print('Title: ${message.notification?.title}');
  print('Body: ${message.notification?.body}');
  print('Payload: ${message.data}');
}

String? mtoken;

class FirebaseApi {
  final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  //third step
  // app in foreground
  initInfo() {
    var androidInitialize =
        const AndroidInitializationSettings('@drawable/ic_launcher');
    var iOSInitialize = const DarwinInitializationSettings();
    var initializationSettings =
        InitializationSettings(android: androidInitialize, iOS: iOSInitialize);
    flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse: (payload) async {
      try {
        if (payload == 200) {
          // move to notification page
        }
      } catch (e) {}
      return;
    });

    // to show info in notification's message when the app was in foreground
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      print("------------onMessage------------");
      print(
          "onMessage: ${message.notification?.title}/${message.notification?.body}");

      BigTextStyleInformation bigTextStyleInformation = BigTextStyleInformation(
        message.notification!.body.toString(),
        htmlFormatBigText: true,
        contentTitle: message.notification!.title.toString(),
        htmlFormatContentTitle: true,
      );
      // to sound
      AndroidNotificationDetails androidPlatformChannelSpecifics =
          AndroidNotificationDetails(
        'dbfood',
        'dbfood',
        importance: Importance.high,
        styleInformation: bigTextStyleInformation,
        priority: Priority.high,
        playSound: true,
        // sound: RawResourceAndroidNotificationSound("Create new fonder in res and named saw then add to it any file be mp3"),
      );
      NotificationDetails platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: const DarwinNotificationDetails(),
      );
      await flutterLocalNotificationsPlugin.show(
        0,
        message.notification?.title,
        message.notification?.body,
        platformChannelSpecifics,
        payload: message.data['body'],
      );
    });
  }

  //soccend step
  void getToken() async {
    await FirebaseMessaging.instance.getToken().then((token) {
      print('My token is $token');
      mtoken = token!;
      Get.find<AuthController>().saveUserTokenFCM(token);
    });
  }

  // first step
  void requestPermission() async {
    final messaging = FirebaseMessaging.instance;

    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User granted permission');
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      print('User granted provisional permission');
    } else {
      print('User declined or has accepted permission');
    }
  }

  Future<void> initNotifications() async {
    requestPermission();
    getToken();
    initInfo();
  }
}