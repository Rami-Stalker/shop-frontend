import 'dart:async';

import 'package:get/get.dart';
import 'package:dio/dio.dart' as diox;

import 'package:flutter/material.dart';
import 'package:shop_app/src/modules/profile_edit/repositories/profile_edit_repository.dart';
import 'package:shop_app/src/resources/local/user_local.dart';
import '../../../controller/app_controller.dart';
import '../../../routes/app_pages.dart';

import '../../../public/components.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../../models/user_model.dart';
import '../../../public/constants.dart';
import '../../../themes/app_colors.dart';

class ProfileEditController extends GetxController implements GetxService {
  final ProfileEditRepository profileEditRepository;
  ProfileEditController({
    required this.profileEditRepository,
  });

  late LatLng initPosition = const LatLng(43.896236, -16.937405);

  bool _loading = false;
  bool get loading => _loading;

  final Rx<Placemark> _placemark = Rx(Placemark());
  Rx<Placemark> get placemark => _placemark;
  final List<String> _addressTypeList = [
    'home',
    'office',
    'others'
  ]; // قائمة نوع العنوان
  List<String> get addressTypeList => _addressTypeList;
  int _addressTypeIndex = 0; // home لفهرس قائمة العنوان هنا صفر يشير الى
  int get addressTypeIndex => _addressTypeIndex;

  Completer<GoogleMapController> _mapController = Completer();
  Completer<GoogleMapController> get mapController => _mapController;

  final TextEditingController addressC = TextEditingController();
  final TextEditingController nameC = TextEditingController();
  final TextEditingController phoneC = TextEditingController();

  @override
  void onClose() {
    addressC.dispose();
    nameC.dispose();
    phoneC.dispose();
    super.onClose();
  }

  void setMapController(GoogleMapController mapController) {
    _mapController.complete(mapController);
  }

  void updatePosition(
    LatLng cPosition,
  ) async {
    _loading = true;
    update();
    try {
      var geocoder = GeocodingPlatform.instance;
      final coordinates = await geocoder.placemarkFromCoordinates(
        cPosition.latitude,
        cPosition.longitude,
      );
      var address = coordinates.first;
      _placemark.value = address;
      _loading = false;
      update();
    } catch (e) {
      print(e);
    }
  }

  void setAddressTypeIndex(int index) {
    _addressTypeIndex = index;
    update();
  }

  void modifyUserInfo(String address, String name, String phone) async {
    UserModel user = AppGet.authGet.userModel!;
    try {
      diox.Response response =
          await profileEditRepository.modifyUserInfo(address, name, phone);

      AppConstants.handleApi(
        response: response,
        onSuccess: () {
          AppGet.authGet.userModel = user;
          UserLocal().saveUser(user);
          Components.showSnackBar(
            "Update your Data Successfully",
            title: 'Update information',
            color: colorPrimary,
          );
          AppNavigator.pop();
          update();
        },
      );
      update();
    } catch (e) {
      Components.showSnackBar(e.toString());
    }
  }
}