import 'dart:io';

import 'package:shop_app/src/modules/auth/controllers/auth_controller.dart';
import 'package:shop_app/src/public/constants.dart';
import '../../../routes/app_pages.dart';
import '../../../themes/app_colors.dart';
import '../../../utils/sizer_custom/sizer.dart';

import '../../../public/components.dart';
import '../../../core/widgets/app_text_button.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/widgets/app_text_field.dart';
import '../../../core/widgets/custom_loader.dart';

import '../../../themes/app_decorations.dart';

class RegisterView extends GetView<AuthController> {
  const RegisterView();

  buildBottomsheet(AuthController authController) => Get.bottomSheet(
        SingleChildScrollView(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(15.sp),
              ),
              color: Get.isDarkMode ? colorBlack : mCL,
            ),
            padding: const EdgeInsetsDirectional.only(
              top: 4,
            ),
            width: SizerUtil.width,
            height: 130.sp,
            child: Column(
              children: [
                Flexible(
                  child: Container(
                    height: 6,
                    width: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        20.sp,
                      ),
                      color:
                          Get.isDarkMode ? Colors.grey[600] : Colors.grey[300],
                    ),
                  ),
                ),
                SizedBox(height: 10.sp),
                Components.buildbottomsheet(
                  icon: Icon(
                    Icons.camera_alt,
                    color: colorBlack,
                  ),
                  label: "Select Image From camera",
                  ontap: () => authController.selectImageFromCamera(),
                ),
                Components.buildbottomsheet(
                  icon: Icon(
                    Icons.photo_library,
                    color: colorBlack,
                  ),
                  label: "Select Image From Gallery",
                  ontap: () => authController.selectImageFromGallery(),
                ),
              ],
            ),
          ),
        ),
        elevation: 0.4,
      );

  Widget buildProfileImage() =>
      GetBuilder<AuthController>(builder: (authController) {
        return GestureDetector(
          onTap: () => buildBottomsheet(authController),
          child: Stack(
            children: [
              CircleAvatar(
                radius: 70.sp,
                backgroundColor: mCL,
                child: authController.photoFile != null
                    ? CircleAvatar(
                        radius: 68.sp,
                        backgroundColor: fCD,
                        backgroundImage: FileImage(
                          authController.photoFile!,
                        ),
                      )
                    : CircleAvatar(
                        radius: 68.sp,
                        backgroundColor: fCD,
                        backgroundImage: NetworkImage(
                          AppConstants.urlImageDefaultPreson,
                        ),
                      ),
              ),
              Positioned(
                bottom: 0.0,
                right: 0.0,
                child: CircleAvatar(
                  radius: 20.sp,
                  backgroundColor: mCL,
                  child: CircleAvatar(
                    radius: 18.sp,
                    backgroundColor: mCH,
                    child: const Icon(Icons.camera_alt),
                  ),
                ),
              ),
            ],
          ),
        );
      });

  void _registration(AuthController authController) {
    String email = controller.emailRC.text.trim();
    String password = controller.passwordRC.text.trim();
    String name = controller.nameRC.text.trim();
    String phoneNumber = controller.phoneRC.text.trim();
    String codeOTP = controller.codeOtpRC.text.trim();
    String phoneCode = authController.countryCode!.phoneCode;
    File? photo = authController.photoFile;

    if (email.isEmpty) {
      Components.showSnackBar(
        'Type your email address',
        title: 'Email address',
      );
    } else if (!GetUtils.isEmail(email)) {
      Components.showSnackBar(
        'Type a valid email address',
        title: 'Valid email address',
      );
    } else if (password.isEmpty) {
      Components.showSnackBar(
        'Type your password',
        title: 'password',
      );
    } else if (password.length < 6) {
      Components.showSnackBar(
        'Password can not less than six characters',
        title: 'password',
      );
    } else if (name.isEmpty) {
      Components.showSnackBar(
        'Type your name',
        title: 'Name',
      );
    } else if (phoneNumber.isEmpty) {
      Components.showSnackBar(
        'Type your phone number',
        title: 'Phone number',
      );
    } else if (codeOTP.isEmpty) {
      Components.showSnackBar(
        'Type code OTP',
        title: 'Phone number',
      );
    } else {
      authController.register(
        photo: photo,
        name: name,
        email: email,
        password: password,
        phoneCode: phoneCode,
        phoneNumber: phoneNumber,
        codeOTP: codeOTP,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<AuthController>(
        builder: (authController) {
          return !authController.isLoading
              ? SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      SizedBox(height: 30.sp),
                      buildProfileImage(),
                      SizedBox(height: 30.sp),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.sp),
                        child: Column(
                          children: [
                            //name
                            AppTextField(
                              textController: controller.nameRC,
                              hintText: 'name',
                              icon: Icons.person,
                            ),
                            SizedBox(height: 10.sp),
                            //email
                            AppTextField(
                              keyboardType: TextInputType.emailAddress,
                              textController: controller.emailRC,
                              hintText: 'email',
                              icon: Icons.email,
                            ),
                            SizedBox(height: 10.sp),

                            //password
                            GetBuilder<AuthController>(
                                builder: (authController) {
                              return AppTextField(
                                textController: controller.passwordRC,
                                hintText: 'password',
                                icon: Icons.password,
                                isObscure: authController.isObscure,
                                suffixIcon: InkWell(
                                  onTap: () {
                                    authController.changeObsure();
                                  },
                                  child: Icon(
                                    authController.isObscure
                                        ? Icons.visibility_outlined
                                        : Icons.visibility_off_outlined,
                                    color: colorPrimary,
                                  ),
                                ),
                              );
                            }),
                            SizedBox(height: 10.sp),

                            //phone
                            Row(
                              children: [
                                Expanded(
                                    flex: 1,
                                    child: GetBuilder<AuthController>(
                                        builder: (authController) {
                                      return _containerWidget(
                                        context: context,
                                        isRight: false,
                                        isLeft: true,
                                        child: TextField(
                                          onTap: () => authController
                                              .pickCountry(context),
                                          readOnly: true,
                                          cursorColor: colorPrimary,
                                          decoration: InputDecoration(
                                            hintText:
                                                '+ ${authController.countryCode != null ? authController.countryCode!.phoneCode : "1"}',
                                            hintStyle: TextStyle(fontSize: 12),
                                            prefixIcon: Icon(
                                              Icons.phone,
                                              color: colorBranch,
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide.none,
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide.none,
                                            ),
                                          ),
                                        ),
                                      );
                                    })),
                                Expanded(
                                  flex: 3,
                                  child: _containerWidget(
                                    context: context,
                                    isRight: true,
                                    isLeft: false,
                                    child: TextField(
                                      keyboardType: TextInputType.number,
                                      controller: controller.phoneRC,
                                      cursorColor: colorBranch,
                                      decoration: InputDecoration(
                                        hintText: "phone",
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide.none,
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide.none,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 10.sp),
                            //verify phone number
                            Row(
                              children: [
                                Expanded(
                                  flex: 4,
                                  child: _containerWidget(
                                    context: context,
                                    isRight: false,
                                    isLeft: true,
                                    child: TextField(
                                      keyboardType: TextInputType.number,
                                      controller: controller.codeOtpRC,
                                      cursorColor: colorBranch,
                                      decoration: InputDecoration(
                                        hintText: "verification code",
                                        prefixIcon: Icon(
                                          Icons.timer_sharp,
                                          color: colorBranch,
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide.none,
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide.none,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: GetBuilder<AuthController>(
                                      builder: (authController) {
                                    return _containerWidget(
                                      context: context,
                                      isRight: true,
                                      isLeft: false,
                                      child: TextField(
                                        keyboardType: TextInputType.number,
                                        readOnly: true,
                                        onTap: () => authController.sendCode(),
                                        decoration: InputDecoration(
                                          prefixIcon: Padding(
                                            padding: EdgeInsets.only(
                                              left: 15.sp,
                                            ),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                !authController.isOnData
                                                    ? Expanded(
                                                        child: Text(
                                                          "send code",
                                                          style: TextStyle(
                                                            color: authController
                                                                    .isOnData
                                                                ? Colors.grey
                                                                : Colors.red,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 13.sp,
                                                          ),
                                                        ),
                                                      )
                                                    : Container(),
                                                SizedBox(width: 10.sp),
                                                authController.isOnData
                                                    ? Text(
                                                        "${authController.current} s",
                                                        style: TextStyle(
                                                          color: Colors.red,
                                                          fontSize: 13,
                                                        ),
                                                      )
                                                    : Container(),
                                              ],
                                            ),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide.none,
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide.none,
                                          ),
                                        ),
                                      ),
                                    );
                                  }),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 20.sp),

                      GetBuilder<AuthController>(builder: (authController) {
                        return AppTextButton(
                          txt: 'register',
                          onTap: () => _registration(authController),
                        );
                      }),

                      SizedBox(
                        height: 10.sp,
                      ),
                      //tag line
                      RichText(
                        text: TextSpan(
                          text: 'Have an account already ',
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge!
                              .copyWith(color: fCL),
                          children: [
                            TextSpan(
                              recognizer: TapGestureRecognizer()
                                ..onTap = () =>
                                    AppNavigator.replaceWith(AppRoutes.LOGIN),
                              text: 'Login',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge!
                                  .copyWith(color: colorPrimary),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: SizerUtil.height * 0.05,
                      ),
                      //sign up options
                      RichText(
                        text: TextSpan(
                          text: 'Sign up using one of the following methods',
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge!
                              .copyWith(color: fCL),
                        ),
                      ),
                    ],
                  ),
                )
              : const CustomLoader();
        },
      ),
    );
  }

  Container _containerWidget({
    required BuildContext context,
    required bool isRight,
    required bool isLeft,
    required Widget child,
  }) {
    return Container(
      decoration: AppDecoration.textfeild(
        context,
        10.sp,
        isLeft: isLeft,
        isRight: isRight,
      ).decoration,
      child: child,
    );
  }
}
