import 'dart:async';

import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as diox;

import 'package:flutter/material.dart';
import 'package:shop_app/src/modules/profile_edit/repositories/profile_edit_repository.dart';
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
  ProfileEditController(this.profileEditRepository);

  late LatLng initPosition = const LatLng(43.896236, -16.937405);

  bool _isLoading = false;
  bool get isLoading => _isLoading;

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

  late TextEditingController addressController;
  late TextEditingController nameController;
  late TextEditingController phoneController;

  @override
  void onInit() {
    getPosition();
    UserModel userInfo = AppGet.authGet.userModel!;
    addressController = TextEditingController(text: userInfo.address);
    nameController = TextEditingController(text: userInfo.name);
    phoneController = TextEditingController(text: userInfo.phone);
    super.onInit();
  }

  @override
  void dispose() {
    addressController.dispose();
    nameController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  bool isPosition = false;
  Future getPosition() async {
    bool services;
    LocationPermission per;

    services = await Geolocator.isLocationServiceEnabled();

    if (services == false) {
      Components.showSnackBar("Services Not Enabled");
    }

    per = await Geolocator.checkPermission();

    if (per == LocationPermission.denied) {
      per = await Geolocator.requestPermission();
    }

    if (per != LocationPermission.denied) {
      var position = await Geolocator.getCurrentPosition();
      initPosition = LatLng(position.latitude, position.longitude);
      isPosition = true;
    }
    update();
  }

  void setMapController(GoogleMapController mapController) {
    _mapController.complete(mapController);
  }

  void updatePosition(
    LatLng cPosition,
  ) async {
    try {
      var geocoder = GeocodingPlatform.instance;
      final coordinates = await geocoder.placemarkFromCoordinates(
        cPosition.latitude,
        cPosition.longitude,
      );
      var address = coordinates.first;
      _placemark.value = address;
      addressController.text =
          '${placemark.value.administrativeArea ?? ''}${placemark.value.locality ?? ''}${placemark.value.street ?? ''}${placemark.value.postalCode ?? ''}';
    } catch (e) {
      print(e);
    }
  }

  void setAddressTypeIndex(int index) {
    _addressTypeIndex = index;
    update();
  }

  void modifyUserInfo(String address, String name, String phone) async {
    // UserModel user = AppGet.authGet.userModel!;
    try {
      _isLoading = true;
      update();
      diox.Response response =
          await profileEditRepository.modifyUserInfo(address, name, phone);

      AppConstants.handleApi(
        response: response,
        onSuccess: () {
          // AppGet.authGet.userModel = user;
          // UserLocal().saveUser(user);
          AppNavigator.pop();
          Components.showSnackBar(
            "Update your Data Successfully",
            title: 'Update information',
            color: colorPrimary,
          );
          AppGet.authGet.GetInfoUser();
          update();
        },
      );
      _isLoading = false;
      update();
    } catch (e) {
      Components.showSnackBar(e.toString());
    }
  }
}
