import 'dart:async';

import 'package:shop_app/app/modules/auth/controllers/auth_controller.dart';
import 'package:shop_app/app/modules/update_profile/controllers/update_profile_controller.dart';

import '../../../core/utils/components/app_components.dart';
import '../../../controller/user_controller.dart';
import '../../../core/widgets/app_icon.dart';
import '../../../core/widgets/app_text_button.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../core/utils/app_colors.dart';
import '../../../core/utils/dimensions.dart';
import '../../../core/widgets/app_text_field.dart';
import '../../../core/widgets/big_text.dart';
import '../../../routes/app_pages.dart';

class UpdateProfileView extends StatefulWidget {
  const UpdateProfileView({super.key});

  @override
  State<UpdateProfileView> createState() => _UpdateProfileViewState();
}

class _UpdateProfileViewState extends State<UpdateProfileView> {
  AuthController authController = Get.find<AuthController>();
  UserController userController = Get.find<UserController>();
  UpdateProfileController addressController = Get.find<UpdateProfileController>();

  late bool _isLogged;

  bool _isPosition = false;
  Future getPosition() async {
    bool services;
    LocationPermission per;

    services = await Geolocator.isLocationServiceEnabled();

    if (services == false) {
      AppComponents.showCustomSnackBar("Services Not Enabled");
    }

    per = await Geolocator.checkPermission();

    if (per == LocationPermission.denied) {
      per = await Geolocator.requestPermission();
    }

    if (per != LocationPermission.denied) {
      var position = await Geolocator.getCurrentPosition();

      setState(() {
        addressController.initPosition =
            LatLng(position.latitude, position.longitude);
        _isPosition = true;
      });
    }
  }

  @override
  void initState() {
    getPosition();
    _isLogged = authController.userLoggedIn();
    if (_isLogged && userController.user.phone == "" || userController.user.phone.isEmpty) {
      authController.getUserData();
    }
    if (userController.user.name.isNotEmpty) {
      addressController.nameC.text = userController.user.name;
    }
    if (userController.user.phone.isNotEmpty) {
      addressController.phoneC.text = userController.user.phone;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            color: AppColors.mainColor,
            width: double.maxFinite,
            height: Dimensions.height10 * 10,
            padding: EdgeInsets.only(
              top: Dimensions.height45,
              left: Dimensions.width20,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppIcon(
                  onTap: () => Get.back(),
                  icon: Icons.arrow_back_ios,
                  backgroundColor: AppColors.originColor,
                ),
                BigText(
                  text: 'Modify profile',
                  color: Colors.white,
                ),
                Container(
                  width: Dimensions.height45,
                ),
              ],
            ),
          ),
          
          GetBuilder<UpdateProfileController>(
            builder: (addressController) {
              addressController.addressC.text =
                  '${addressController.placemark.value.administrativeArea ?? ''}${addressController.placemark.value.locality ?? ''}${addressController.placemark.value.street ?? ''}${addressController.placemark.value.postalCode ?? ''}';
              return MediaQuery.removePadding(
                context: context,
                removeTop: true,
                child: Expanded(
                  child: ListView(
                    children: [
                      Container(
                        height: 160,
                        width: Dimensions.screenWidth,
                        margin: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(
                            width: 2,
                            color: AppColors.mainColor,
                          ),
                        ),
                        child: _isPosition != false
                            ? GoogleMap(
                                mapType: MapType.hybrid,
                                initialCameraPosition: CameraPosition(
                                  target: addressController.initPosition,
                                  zoom: 17.0,
                                ),
                                onTap: (latLng) {
                                  Get.toNamed(
                                    Routes.ADDRESS,
                                  );
                                },
                                myLocationEnabled: true,
                                onMapCreated: (GoogleMapController controller) =>
                                    addressController.setMapController(controller),
                                zoomControlsEnabled: false,
                                compassEnabled: false,
                                indoorViewEnabled: true,
                                mapToolbarEnabled: false,
                                onCameraMove: ((position) {
                                  addressController.initPosition = LatLng(
                                    position.target.latitude,
                                    position.target.longitude,
                                  );
                                }),
                                onCameraIdle: () {
                                  addressController.updatePosition(addressController.initPosition);
                                },
                              )
                            : Container(),
                      ),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(
                            left: Dimensions.width20,
                            right: Dimensions.width20,
                          ),
                          child: ListView(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: Dimensions.height10 - 5),
                                SizedBox(
                                  height: Dimensions.height45 + 5,
                                  child: ListView.builder(
                                      shrinkWrap: true,
                                      scrollDirection: Axis.horizontal,
                                      itemCount: addressController.addressTypeList.length,
                                      itemBuilder: (context, index) {
                                        return InkWell(
                                          onTap: () {
                                            addressController.setAddressTypeIndex(index);
                                          },
                                          child: Container(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: Dimensions.width30,
                                                vertical: Dimensions.height10),
                                            margin: EdgeInsets.only(
                                                right: Dimensions.width10),
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(
                                                  Dimensions.radius20 / 4),
                                              color: Theme.of(context).cardColor,
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.grey[200]!,
                                                  spreadRadius: 1,
                                                  blurRadius: 5,
                                                ),
                                              ],
                                            ),
                                            child: Icon(
                                              index == 0
                                                  ? Icons.home_filled
                                                  : index == 1
                                                      ? Icons.work
                                                      : Icons.location_on,
                                              color:
                                                  addressController.addressTypeIndex == index
                                                      ? AppColors.mainColor
                                                      : Theme.of(context).disabledColor,
                                            ),
                                          ),
                                        );
                                      }),
                                ),
                                SizedBox(height: Dimensions.height20),
                                BigText(
                                  text: 'Delivery Address',
                                ),
                                SizedBox(
                                  height: Dimensions.height10,
                                ),
                                AppTextField(
                                  textController: addressController.addressC,
                                  hintText: 'Your address',
                                  icon: Icons.map,
                                ),
                                SizedBox(height: Dimensions.height20),
                                BigText(
                                  text: 'Delivery Name',
                                ),
                                SizedBox(
                                  height: Dimensions.height10,
                                ),
                                AppTextField(
                                  textController: addressController.nameC,
                                  hintText: 'Your name',
                                  icon: Icons.person,
                                ),
                                SizedBox(height: Dimensions.height20),
                                BigText(
                                  text: 'Delivery Phone',
                                ),
                                SizedBox(
                                  height: Dimensions.height10,
                                ),
                                AppTextField(
                                  keyboardType: TextInputType.phone,
                                  textController: addressController.phoneC,
                                  hintText: 'Your Phone',
                                  icon: Icons.phone,
                                ),
                              ],
                            ),
                          ]),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
      bottomNavigationBar:
          GetBuilder<UpdateProfileController>(builder: (addressCtrl) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: Dimensions.height20 * 7,
              decoration: BoxDecoration(
                color: AppColors.buttonBackgroundColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(Dimensions.radius20 * 2),
                  topRight: Radius.circular(Dimensions.radius20 * 2),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AppTextButton(
                    txt: 'Save modifications',
                    onTap: () {
                      if (addressCtrl.addressC.text.isNotEmpty) {
                        addressCtrl.saveUserData(
                          addressCtrl.addressC.text,
                          addressCtrl.nameC.text,
                          addressCtrl.phoneC.text,
                        );
                        Get.back();
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        );
      }),
    );
  }
}
