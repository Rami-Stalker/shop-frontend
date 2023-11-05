import 'dart:async';

import 'package:shop_app/src/controller/app_controller.dart';
import 'package:shop_app/src/core/widgets/app_text.dart';
import 'package:shop_app/src/core/widgets/custom_button.dart';
import 'package:shop_app/src/models/user_model.dart';

import '../../../routes/app_pages.dart';
import '../controllers/profile_edit_controller.dart';
import '../../../utils/sizer_custom/sizer.dart';

import '../../../public/components.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../core/widgets/app_text_field.dart';
import '../../../themes/app_colors.dart';
import '../../auth/controllers/auth_controller.dart';

class EditInfoView extends StatefulWidget {
  const EditInfoView({super.key});

  @override
  State<EditInfoView> createState() => _EditInfoViewState();
}

class _EditInfoViewState extends State<EditInfoView> {
  AuthController authController = AppGet.authGet;
  UserModel user = AppGet.authGet.userModel!;
  ProfileEditController addressController = AppGet.updateProfileGet;

  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

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
    if (_isLogged && user.phone == "" || user.phone.isEmpty) {
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
      body: GetBuilder<ProfileEditController>(
        builder: (updateProfileController) {
          updateProfileController.addressC.text =
              '${updateProfileController.placemark.value.administrativeArea ?? ''}${updateProfileController.placemark.value.locality ?? ''}${updateProfileController.placemark.value.street ?? ''}${updateProfileController.placemark.value.postalCode ?? ''}';
          return Stack(
            children: [
              ListView(
                physics: const BouncingScrollPhysics(),
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5.sp),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 5.sp),
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
                                    target:
                                        updateProfileController.initPosition,
                                    zoom: 17.0,
                                  ),
                                  onTap: (latLng) {
                                    AppNavigator.push(
                                      AppRoutes.ADDRESS,
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
                                    updateProfileController.initPosition =
                                        LatLng(
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
                                return GestureDetector(
                                  onTap: () {
                                    updateProfileController
                                        .setAddressTypeIndex(index);
                                  },
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 30.sp,
                                      vertical: 10.sp,
                                    ),
                                    margin: EdgeInsets.only(
                                      right: 10.sp,
                                    ),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(
                                        5.sp,
                                      ),
                                      color: Theme.of(context).cardColor,
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
                                          : Theme.of(context).disabledColor,
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
                        AppText('Delivery Address'),
                        SizedBox(
                          height: 10.sp,
                        ),
                        AppTextField(
                          textController: _addressController,
                          hintText: 'Your address',
                          icon: Icons.map,
                        ),
                        SizedBox(height: 20.sp),
                        AppText('Delivery Name'),
                        SizedBox(
                          height: 10.sp,
                        ),
                        AppTextField(
                          textController: _nameController,
                          hintText: 'Your name',
                          icon: Icons.person,
                        ),
                        SizedBox(height: 20.sp),
                        AppText('Delivery Phone'),
                        SizedBox(height: 10.sp),
                        AppTextField(
                          keyboardType: TextInputType.phone,
                          textController: _phoneController,
                          hintText: 'Your Phone',
                          icon: Icons.phone,
                        ),
                        SizedBox(height: 10.sp)
                      ],
                    ),
                  ),
                ],
              ),
              Positioned(
                bottom: 20.sp,
                right: 0.0,
                left: 0.0,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 40.sp,
                  ),
                  child: CustomButton(
                    buttomText: "Save Modifications",
                    onPressed: _addressController.text.isEmpty ||
                            _nameController.text.isEmpty ||
                            _phoneController.text.isEmpty
                        ? null
                        : () {
                            updateProfileController.modifyUserInfo(
                              _addressController.text,
                              _nameController.text,
                              _phoneController.text,
                            );
                            AppNavigator.pop();
                          },
                  ),
                ),
              ),
            ],
          );
        },
      ),
      // bottomNavigationBar: Container(
      //   height: 80.sp,
      //   padding: EdgeInsets.symmetric(
      //     horizontal: 20.sp,
      //     vertical: 20.sp,
      //   ),
      //   decoration: BoxDecoration(
      //     color: Get.isDarkMode ? fCD : mCD,
      //     borderRadius: BorderRadius.only(
      //       topLeft: Radius.circular(45.sp),
      //       topRight: Radius.circular(45.sp),
      //     ),
      //   ),
      //   child: GetBuilder<ProfileEditController>(
      //       builder: (updateProfileController) {
      //     return CustomButton(
      //       buttomText: 'Save Modifications',
      //       onPressed: () {
      //         if (_addressController.text.isNotEmpty) {
      //           updateProfileController.modifyUserInfo(
      //             _addressController.text,
      //             _nameController.text,
      //             _phoneController.text,
      //           );
      //           AppNavigator.pop();
      //         }
      //       },
      //     );
      //   }),
      // ),
    );
  }
}
