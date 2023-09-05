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
      appBar: Components.customAppBar(context, "Modify Info"),
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
                          width: SizerUtil.width,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(
                              width: 2.sp,
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
                                    AppNavigator.push(
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
                        SizedBox(height: 10.sp),
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
                                            30.sp,
                                        vertical: 10.sp,
                                      ),
                                      margin: EdgeInsets.only(
                                        right: 10.sp,
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
                      horizontal: 20.sp,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 20.sp),
                        Text(
                          'Delivery Address',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        SizedBox(
                          height: 10.sp,
                        ),
                        AppTextField(
                          textController:
                              updateProfileController.addressC,
                          hintText: 'Your address',
                          icon: Icons.map,
                        ),
                        SizedBox(height: 20.sp),
                        Text(
                          'Delivery Name',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        SizedBox(
                          height: 10.sp,
                        ),
                        AppTextField(
                          textController: updateProfileController.nameC,
                          hintText: 'Your name',
                          icon: Icons.person,
                        ),
                        SizedBox(height: 20.sp),
                        Text(
                          'Delivery Phone',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        SizedBox(
                          height: 10.sp,
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
          horizontal: 20.sp,
          vertical: 20.sp,
        ),
        decoration: BoxDecoration(
          color: Get.isDarkMode ? fCD : mCD,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(45.sp),
            topRight: Radius.circular(45.sp),
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
                        AppNavigator.pop();
                      }
              },
            );
          }
        ),
      ),
    );
  }
}
