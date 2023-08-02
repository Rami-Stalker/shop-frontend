import 'package:flutter/material.dart';
import 'package:shop_app/src/app.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

import 'src/config/application.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await Application().initialAppLication();

  // await PayPalConfiguration.instance.setup(
  //   clientId: 'YOUR_CLIENT_ID', // Replace with your PayPal Client ID
  //   secret: 'YOUR_SECRET_KEY', // Replace with your PayPal Secret Key
  //   environment: PayPalEnvironment.Sandbox, // Use PayPalEnvironment.Production for production
  // );
  runApp(App());
}
