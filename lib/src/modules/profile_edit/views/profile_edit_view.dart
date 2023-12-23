import 'package:shop_app/src/core/widgets/app_text.dart';
import 'package:shop_app/src/core/widgets/custom_button.dart';
import 'package:shop_app/src/core/widgets/custom_loader.dart';

import '../../../routes/app_pages.dart';
import '../controllers/profile_edit_controller.dart';
import '../../../utils/sizer_custom/sizer.dart';

import '../../../public/components.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../core/widgets/app_text_field.dart';
import '../../../themes/app_colors.dart';

class EditInfoView extends GetView<ProfileEditController> {
  const EditInfoView({super.key});

//   @override
//   State<EditInfoView> createState() => _EditInfoViewState();
// }

// class _EditInfoViewState extends State<EditInfoView> {


  // @override
  // void initState() {
  //   getPosition();
  //   _isLogged = authController.onAuthCheck();
  //   if (_isLogged && user.phone == "" || user.phone.isEmpty) {
  //     authController.GetInfoUser();
  //   }
  //   if (user.name.isNotEmpty) {
  //     addressController.nameC.text = user.name;
  //   }
  //   if (user.phone.isNotEmpty) {
  //     addressController.phoneC.text = user.phone;
  //   }
  //   super.initState();
  // }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Components.customAppBar(context, 'modi_info'.tr),
      body: GetBuilder<ProfileEditController>(
        builder: (updateProfileController) {
          // updateProfileController.addressController.text =
          //     '${updateProfileController.placemark.value.administrativeArea ?? ''}${updateProfileController.placemark.value.locality ?? ''}${updateProfileController.placemark.value.street ?? ''}${updateProfileController.placemark.value.postalCode ?? ''}';
          return !updateProfileController.isLoading ?
          Stack(
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
                          child: updateProfileController.isPosition != false
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
                        AppText('delivery_address'.tr),
                        SizedBox(
                          height: 10.sp,
                        ),
                        AppTextField(
                          textController: controller.addressController,
                          hintText: 'delivery_address'.tr,
                          icon: Icons.map,
                        ),
                        SizedBox(height: 20.sp),
                        AppText('delivery_name'.tr),
                        SizedBox(
                          height: 10.sp,
                        ),
                        AppTextField(
                          textController: controller.nameController,
                          hintText: 'delivery_name'.tr,
                          icon: Icons.person,
                        ),
                        SizedBox(height: 20.sp),
                        AppText('delivery_phone'.tr),
                        SizedBox(height: 10.sp),
                        AppTextField(
                          keyboardType: TextInputType.phone,
                          textController: controller.phoneController,
                          hintText: 'delivery_phone'.tr,
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
                    buttomText: 'save_modi'.tr,
                    onPressed: controller.addressController.text.trim().isEmpty ||
                            controller.nameController.text.trim().isEmpty ||
                            controller.phoneController.text.trim().isEmpty
                        ? null
                        : () {
                            updateProfileController.modifyUserInfo(
                              controller.addressController.text,
                              controller.nameController.text,
                              controller.phoneController.text,
                            );
                          },
                  ),
                ),
              ),
            ],
          ) : CustomLoader();
        },
      ),
    );
  }
}
