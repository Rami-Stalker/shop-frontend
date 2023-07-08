import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/app/api/firebase_api.dart';
import 'package:shop_app/origin.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:shop_app/app/helper/dependencies.dart' as dep;

// message in background
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print('Handle a background message ${message.messageId}');
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FirebaseMessaging.instance.getInitialMessage();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  await dep.init();
  await FirebaseApi().initNotifications();
  runApp(ShopApp());
}
