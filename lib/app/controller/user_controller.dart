import 'package:get/get.dart';

import '../models/user_model.dart';

class UserController extends GetxController{
  UserModel _user = UserModel(
    id: '',
    name: '',
    email: '',
    password: '',
    phone: '',
    address: '',
    type: '',
    token: '',
  );

  UserModel get user => _user;

  void setUserFromJson(String user) {
    _user = UserModel.fromJson(user);
    update();
  }

  void setUserFromModel(UserModel user) {
    _user = user;
    update();
  }
}