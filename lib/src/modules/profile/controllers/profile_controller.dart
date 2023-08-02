import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../routes/app_pages.dart';

class ProfileController extends GetxController {
  final SharedPreferences sharedPreferences;
  ProfileController({
    required this.sharedPreferences,
  });
  
  void logOut() async {
    try {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      await sharedPreferences.setString('x-auth-token', '');
      Get.offNamedUntil(Routes.SIGN_IN, (route) => false);
    } catch (e) {
      Get.snackbar('', e.toString());
    }
  }
}
