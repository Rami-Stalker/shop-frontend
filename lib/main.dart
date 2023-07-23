import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shop_app/app/helper/push_notification_service.dart';
import 'package:shop_app/origin.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:shop_app/app/helper/dependencies.dart' as dep;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // await FirebaseMessaging.instance.getInitialMessage();
  await GetStorage.init();
  await dep.init();
  await PushNotificationService().initialise();
  runApp(ShopApp());
}
