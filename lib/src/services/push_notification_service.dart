import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:shop_app/src/modules/auth/controllers/auth_controller.dart';

Future<void> handleBackgroundMessage(RemoteMessage message) async {
  print('Title: ${message.notification?.title}');
  print('Body: ${message.notification?.body}');
  print('Payload: ${message.data}');
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print('Received background notification: ${message.notification?.title}');
}

class PushNotificationService {
  final FirebaseMessaging _fcm = FirebaseMessaging.instance;
  final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  initInfo() {
    // Configure callback for handling notifications when the app is in the opened
    var androidInitialize =
        const AndroidInitializationSettings('@drawable/logo');
    var iOSInitialize = const DarwinInitializationSettings();
    var initializationSettings =
        InitializationSettings(android: androidInitialize, iOS: iOSInitialize);
    flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse: (payload) async {
      try {
        if (payload == 200) {}
      } catch (e) {}
      return;
    });

    // Configure callback for handling notifications when the app is in the foreground
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

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      try {
        if (message.notification?.titleLocKey != null) {
          
        }
      } catch (e) {
        
      }
    });
    // Configure callback for handling notifications when the app is in the background or terminated
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  }

  void getToken() async {
    await _fcm.getToken().then((token) {
      print('My token is $token');
      Get.find<AuthController>().saveUserTokenFCM(token!);
    });
  }

  // Request permission for receiving notifications
  void requestPermission() async {
    // final messaging = FirebaseMessaging.instance;

    NotificationSettings settings = await _fcm.requestPermission();

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User granted permission');
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      print('User granted provisional permission');
    } else {
      print('User declined or has accepted permission');
    }
  }

  Future<void> initialise() async {
    requestPermission();
    getToken();
    initInfo();
  }
}
