import 'package:flutter/material.dart';
import 'package:shop_app/origin.dart';
import 'package:shop_app/app/helper/dependencies.dart' as dep;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  await dep.init();
  runApp(ShoppingApp());
}
// void main() {
//   runApp(
//     GetMaterialApp(
//       title: "Application",
//       initialRoute: AppPages.INITIAL,
//       getPages: AppPages.routes,
//     ),
//   );
// }
