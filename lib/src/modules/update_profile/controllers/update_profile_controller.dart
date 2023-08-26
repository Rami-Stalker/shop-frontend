  import 'dart:async';
  import 'dart:convert';

  import 'package:flutter/material.dart';
import '../repositories/update_profile_repository.dart';

  import '../../../public/components.dart';
  import '../../../controller/user_controller.dart';
  import 'package:geocoding/geocoding.dart';
  import 'package:get/get.dart';
  import 'package:google_maps_flutter/google_maps_flutter.dart';
  import 'package:http/http.dart' as http;
  import '../../../models/user_model.dart';
  import '../../../public/constants.dart';
  import '../../../themes/app_colors.dart';

  class UpdateProfileController extends GetxController implements GetxService {
    final UpdateProfileRepository updateProfileRepository;
    UpdateProfileController({
      required this.updateProfileRepository,
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

    void updatePosition(LatLng cPosition,) async {
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

    void saveUserData(String address, String name, String phone) async {
      UserController userCtrl = Get.find<UserController>();
      try {
        http.Response res = await updateProfileRepository.saveUserData(address, name, phone);

        Constants.httpErrorHandle(
          res: res,
          onSuccess: () {
            UserModel user = userCtrl.user.copyWith(
              address: jsonDecode(res.body)['address'],
              name: jsonDecode(res.body)['name'],
              phone: jsonDecode(res.body)['phone'],
            );
            userCtrl.setUserFromModel(user);
            Components.showSnackBar(
              "Update your Data Successfully",
              title: 'Update information',
              color: colorPrimary,
            );
          },
        );
        update();
      } catch (e) {
        Components.showSnackBar(e.toString());
      }
    }
  }
