import 'dart:async';

import 'package:shop_app/src/controller/app_controller.dart';
import 'package:shop_app/src/models/user_model.dart';

import '../controllers/update_profile_controller.dart';
import '../../../utils/sizer_custom/sizer.dart';

import '../../../public/components.dart';
import '../../../core/widgets/app_text_button.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../core/widgets/app_text_field.dart';
import '../../../routes/app_pages.dart';
import '../../../themes/app_colors.dart';
import '../../../themes/app_decorations.dart';
import '../../auth/controllers/auth_controller.dart';

class UpdateProfileView extends StatefulWidget {
  const UpdateProfileView({super.key});

  @override
  State<UpdateProfileView> createState() => _UpdateProfileViewState();
}

class _UpdateProfileViewState extends State<UpdateProfileView> {
  AuthController authController = AppGet.authGet;
  UserModel user = AppGet.authGet.userModel!;
  UpdateProfileController addressController =
      AppGet.updateProfileGet;

  late bool _isLogged;

  bool _isPosition = false;
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
    _isLogged = authController.onAuthCheck();
    if (_isLogged && user.phone == "" ||
        user.phone.isEmpty) {
      authController.GetInfoUser();
    }
    if (user.name.isNotEmpty) {
      addressController.nameC.text = user.name;
    }
    if (user.phone.isNotEmpty) {
      addressController.phoneC.text = user.phone;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Modify Profile",
          style: Theme.of(context).textTheme.titleLarge,
        ),
        leading: Container(
          padding: EdgeInsets.all(8.sp),
          child: InkWell(
            onTap: () => Get.back(),
            child: Container(
              padding: EdgeInsets.all(5.sp),
              decoration: AppDecoration.appbarIcon(context, 5.sp).decoration,
              child: Icon(
                Icons.arrow_back_ios,
                size: 15.sp,
                color: Get.isDarkMode ? mCL : colorBlack,
              ),
            ),
          ),
        ),
        bottom: PreferredSize(
          child: Divider(),
          preferredSize: Size(
            Dimensions.screenWidth,
            20,
          ),
        ),
      ),
      body: GetBuilder<UpdateProfileController>(
            builder: (updateProfileController) {
              updateProfileController.addressC.text =
                  '${updateProfileController.placemark.value.administrativeArea ?? ''}${updateProfileController.placemark.value.locality ?? ''}${updateProfileController.placemark.value.street ?? ''}${updateProfileController.placemark.value.postalCode ?? ''}';
              return ListView(
                physics: const BouncingScrollPhysics(),
                children: [
                  Padding(
                    padding: EdgeInsets.all(5.sp),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 130.sp,
                          width: Dimensions.screenWidth,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(
                              width: 2,
                              color: colorPrimary,
                            ),
                          ),
                          child: _isPosition != false
                              ? GoogleMap(
                                  mapType: MapType.hybrid,
                                  initialCameraPosition: CameraPosition(
                                    target: updateProfileController.initPosition,
                                    zoom: 17.0,
                                  ),
                                  onTap: (latLng) {
                                    Get.toNamed(
                                      Routes.ADDRESS,
                                    );
                                  },
                                  myLocationEnabled: true,
                                  onMapCreated:
                                      (GoogleMapController controller) =>
                                          updateProfileController
                                              .setMapController(controller),
                                  zoomControlsEnabled: false,
                                  compassEnabled: false,
                                  indoorViewEnabled: true,
                                  mapToolbarEnabled: false,
                                  onCameraMove: ((position) {
                                    updateProfileController.initPosition = LatLng(
                                      position.target.latitude,
                                      position.target.longitude,
                                    );
                                  }),
                                  onCameraIdle: () {
                                    updateProfileController.updatePosition(
                                        updateProfileController.initPosition);
                                  },
                                )
                              : Container(),
                        ),
                        SizedBox(height: Dimensions.height10),
                    SizedBox(
                            height: 50.sp,
                            child: ListView.builder(
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                itemCount: updateProfileController
                                    .addressTypeList.length,
                                itemBuilder: (context, index) {
                                  return InkWell(
                                    onTap: () {
                                      updateProfileController
                                          .setAddressTypeIndex(index);
                                    },
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal:
                                            Dimensions.width30,
                                        vertical: Dimensions.height10,
                                      ),
                                      margin: EdgeInsets.only(
                                        right: Dimensions.width10,
                                      ),
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(
                                          5.sp,
                                        ),
                                        color: Theme.of(context)
                                            .cardColor,
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
                                        color: updateProfileController
                                                    .addressTypeIndex ==
                                                index
                                            ? colorPrimary
                                            : Theme.of(context)
                                                .disabledColor,
                                      ),
                                    ),
                                  );
                                }),
                          ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: Dimensions.width20,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: Dimensions.height20),
                        Text(
                          'Delivery Address',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        SizedBox(
                          height: Dimensions.height10,
                        ),
                        AppTextField(
                          textController:
                              updateProfileController.addressC,
                          hintText: 'Your address',
                          icon: Icons.map,
                        ),
                        SizedBox(height: Dimensions.height20),
                        Text(
                          'Delivery Name',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        SizedBox(
                          height: Dimensions.height10,
                        ),
                        AppTextField(
                          textController: updateProfileController.nameC,
                          hintText: 'Your name',
                          icon: Icons.person,
                        ),
                        SizedBox(height: Dimensions.height20),
                        Text(
                          'Delivery Phone',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        SizedBox(
                          height: Dimensions.height10,
                        ),
                        AppTextField(
                          keyboardType: TextInputType.phone,
                          textController: updateProfileController.phoneC,
                          hintText: 'Your Phone',
                          icon: Icons.phone,
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        
      bottomNavigationBar: Container(
        height: 80.sp,
        padding: EdgeInsets.symmetric(
          horizontal: Dimensions.width20,
          vertical: Dimensions.height20,
        ),
        decoration: BoxDecoration(
          color: Get.isDarkMode ? fCD : mCD,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(Dimensions.radius45),
            topRight: Radius.circular(Dimensions.radius45),
          ),
        ),
        child: GetBuilder<UpdateProfileController>(
          builder: (updateProfileController) {
            return AppTextButton(
              txt: 'Save Modifications',
              onTap: () {
                if (updateProfileController.addressC.text.isNotEmpty) {
                        updateProfileController.modifyUserInfo(
                          updateProfileController.addressC.text,
                          updateProfileController.nameC.text,
                          updateProfileController.phoneC.text,
                        );
                        Get.back();
                      }
              },
            );
          }
        ),
      ),
    );
  }
}
