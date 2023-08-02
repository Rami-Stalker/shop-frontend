import 'dart:io';

import 'package:shop_app/src/core/picker/picker.dart';
import 'package:shop_app/src/modules/auth/controllers/auth_controller.dart';
import 'package:shop_app/src/public/constants.dart';
import 'package:shop_app/src/utils/sizer_custom/sizer.dart';

import '../../../core/utils/components/app_components.dart';
import '../../../core/widgets/app_text_button.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/utils/app_colors.dart';
import '../../../core/widgets/app_text_field.dart';
import '../../../core/widgets/custom_loader.dart';
import '../../../routes/app_pages.dart';
import 'package:country_picker/country_picker.dart';
import 'package:quiver/async.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  File? image;

  void pickImageGallery() async {
    image = await pickImageFromGallery();
    Get.back();
    setState(() {});
  }

  void pickImageCamera() async {
    image = await pickImageFromCamera();
    Get.back();
    setState(() {});
  }

  Country? countryCode;

  void _pickCountry() {
    showCountryPicker(
      context: context,
      showPhoneCode: true,
      countryListTheme: CountryListThemeData(
        bottomSheetHeight: MediaQuery.of(context).size.height - 300,
      ),
      onSelect: (Country _country) {
        setState(() {
          countryCode = _country;
        });
      },
    );
  }

  int _start = 28;
  int _current = 10;
  bool isOnData = false;

  void startTimer() {
    CountdownTimer countDownTimer = new CountdownTimer(
      new Duration(seconds: _start),
      new Duration(seconds: 1),
    );

    var sub = countDownTimer.listen(null);
    sub.onData((duration) {
      setState(() {
        _current = _start - duration.elapsed.inSeconds;
        isOnData = true;
      });
    });

    sub.onDone(() {
      print("Done");
      _current = 28;
      isOnData = false;
      sub.cancel();
    });
  }

  void _sendCode(AuthController authController) {
    String phoneNumber = authController.phoneUC.text.trim();

    if (!isOnData) {
      if (phoneNumber.isNotEmpty) {
        startTimer();
        authController.sendOtP(
          phoneCode: countryCode!.phoneCode,
          phoneNumber: '${authController.phoneUC.text.trim()}',
        );
      } else {
        AppComponents.showCustomSnackBar(
          'Type your number until sent to you code OTP',
          title: 'Code OTP',
        );
      }
    }
  }

  void _registration(AuthController authController) {
    String email = authController.emailUC.text.trim();
    String password = authController.passwordUC.text.trim();
    String name = authController.nameUC.text.trim();
    String phoneNumber = authController.phoneUC.text.trim();
    String codeOTP = authController.codeOtpUC.text.trim();

    if (email.isEmpty) {
      AppComponents.showCustomSnackBar(
        'Type your email address',
        title: 'Email address',
      );
    } else if (!GetUtils.isEmail(email)) {
      AppComponents.showCustomSnackBar(
        'Type a valid email address',
        title: 'Valid email address',
      );
    } else if (password.isEmpty) {
      AppComponents.showCustomSnackBar(
        'Type your password',
        title: 'password',
      );
    } else if (password.length < 6) {
      AppComponents.showCustomSnackBar(
        'Password can not less than six characters',
        title: 'password',
      );
    } else if (name.isEmpty) {
      AppComponents.showCustomSnackBar(
        'Type your name',
        title: 'Name',
      );
    } else if (phoneNumber.isEmpty) {
      AppComponents.showCustomSnackBar(
        'Type your phone number',
        title: 'Phone number',
      );
    } else if (codeOTP.isEmpty) {
      AppComponents.showCustomSnackBar(
        'Type code OTP',
        title: 'Phone number',
      );
    } else {
      authController.signUpUser(
        photo: image,
        name: name,
        email: email,
        password: password,
        phoneCode: countryCode!.phoneCode,
        phoneNumber: phoneNumber,
        codeOTP: codeOTP,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: GetBuilder<AuthController>(
        builder: (authController) => !authController.isLoading
            ? SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    SizedBox(
                      height: Dimensions.screenHeight * 0.05,
                    ),
                    //app logo
                    SizedBox(
                      height: 200.sp,
                      width: Dimensions.screenWidth,
                      child: Container(
                        alignment: Alignment.center,
                        child: Stack(
                          alignment: AlignmentDirectional.center,
                          children: [
                            CircleAvatar(
                              radius: 80.sp,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: AppColors.mainColor,
                                  shape: BoxShape.circle,
                                ),
                                child: image != null
                                    ? CircleAvatar(
                                        radius: 80.sp,
                                        backgroundImage: FileImage(image!),
                                      )
                                    : CircleAvatar(
                                        radius: 80.sp,
                                        backgroundImage: AssetImage(
                                          Constants.PERSON_ASSET,
                                        ),
                                      ),
                              ),
                            ),
                            Positioned(
                              bottom: 0.0,
                              right: 0.0,
                              child: InkWell(
                                onTap: () {
                                  Get.bottomSheet(
                                    SingleChildScrollView(
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                              Dimensions.radius15),
                                          color: Get.isDarkMode
                                              ? Colors.black
                                              : Colors.white,
                                        ),
                                        padding:
                                            const EdgeInsetsDirectional.only(
                                          top: 4,
                                        ),
                                        width: Dimensions.screenWidth,
                                        height: 150.sp,
                                        child: Column(
                                          children: [
                                            Flexible(
                                              child: Container(
                                                height: 6.sp,
                                                width: 120.sp,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                  color: Get.isDarkMode
                                                      ? Colors.grey[600]
                                                      : Colors.grey[300],
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              height: Dimensions.height10,
                                            ),
                                            AppComponents.buildbottomsheet(
                                              icon: Icon(
                                                Icons.camera,
                                                color: AppColors.mainColor,
                                              ),
                                              label: "From camera",
                                              ontap: pickImageCamera,
                                            ),
                                            Divider(
                                              color: Get.isDarkMode
                                                  ? Colors.white
                                                  : Colors.black,
                                            ),
                                            AppComponents.buildbottomsheet(
                                              icon: Icon(
                                                Icons.image,
                                                color: AppColors.mainColor,
                                              ),
                                              label: "From Gallery",
                                              ontap: pickImageGallery,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    elevation: 0.4,
                                  );
                                },
                                child: CircleAvatar(
                                  radius: 20.sp,
                                  backgroundColor: AppColors.mainColor,
                                  child: Icon(Icons.camera_alt_outlined,
                                      size: Dimensions.iconSize24 + 10),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: Dimensions.width20),
                      child: Column(
                        children: [
                          //name
                          AppTextField(
                            textController: authController.nameUC,
                            hintText: 'name',
                            icon: Icons.person,
                          ),
                          SizedBox(
                            height: Dimensions.height20,
                          ),
                          //email
                          AppTextField(
                            keyboardType: TextInputType.emailAddress,
                            textController: authController.emailUC,
                            hintText: 'email',
                            icon: Icons.email,
                          ),
                          SizedBox(
                            height: Dimensions.height20,
                          ),
                          //password
                          GetBuilder<AuthController>(builder: (authController) {
                            return AppTextField(
                              textController: authController.passwordUC,
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
                                  color: AppColors.originColor,
                                ),
                              ),
                            );
                          }),
                          SizedBox(
                            height: Dimensions.height20,
                          ),
                          //phone
                          Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.only(
                                      topLeft:
                                          Radius.circular(Dimensions.radius15),
                                      bottomLeft:
                                          Radius.circular(Dimensions.radius15),
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        blurRadius: 3,
                                        spreadRadius: 1,
                                        offset: const Offset(1, 1),
                                        color: Colors.grey.withOpacity(0.2),
                                      ),
                                    ],
                                  ),
                                  child: TextField(
                                    onTap: _pickCountry,
                                    readOnly: true,
                                    decoration: InputDecoration(
                                      hintText:
                                          '+ ${countryCode != null ? countryCode!.phoneCode : "1"}',
                                      hintStyle: TextStyle(fontSize: 12),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                          width: 1.0,
                                          color: Colors.white,
                                        ),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                          width: 1.0,
                                          color: Colors.white,
                                        ),
                                      ),
                                      prefixIcon: Icon(
                                        Icons.phone,
                                        color: AppColors.originColor,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 3,
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.only(
                                      topRight:
                                          Radius.circular(Dimensions.radius15),
                                      bottomRight:
                                          Radius.circular(Dimensions.radius15),
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        blurRadius: 3,
                                        spreadRadius: 1,
                                        offset: const Offset(1, 1),
                                        color: Colors.grey.withOpacity(0.2),
                                      ),
                                    ],
                                  ),
                                  child: TextField(
                                    keyboardType: TextInputType.number,
                                    controller: authController.phoneUC,
                                    decoration: InputDecoration(
                                      hintText: "phone",
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                          width: 1.0,
                                          color: Colors.white,
                                        ),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                          width: 1.0,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: Dimensions.height20,
                          ),
                          //verify phone number
                          Row(
                            children: [
                              Expanded(
                                flex: 5,
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.only(
                                      topLeft:
                                          Radius.circular(Dimensions.radius15),
                                      bottomLeft:
                                          Radius.circular(Dimensions.radius15),
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        blurRadius: 3,
                                        spreadRadius: 1,
                                        offset: const Offset(1, 1),
                                        color: Colors.grey.withOpacity(0.2),
                                      ),
                                    ],
                                  ),
                                  child: TextField(
                                    keyboardType: TextInputType.number,
                                    controller: authController.codeOtpUC,
                                    decoration: InputDecoration(
                                      hintText: "verification code",
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                          width: 1.0,
                                          color: Colors.white,
                                        ),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                          width: 1.0,
                                          color: Colors.white,
                                        ),
                                      ),
                                      prefixIcon: Icon(
                                        Icons.timer_sharp,
                                        color: AppColors.originColor,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.only(
                                      topRight:
                                          Radius.circular(Dimensions.radius15),
                                      bottomRight:
                                          Radius.circular(Dimensions.radius15),
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        blurRadius: 3,
                                        spreadRadius: 1,
                                        offset: const Offset(1, 1),
                                        color: Colors.grey.withOpacity(0.2),
                                      ),
                                    ],
                                  ),
                                  child: TextField(
                                    keyboardType: TextInputType.number,
                                    controller: authController.codeOtpUC,
                                    readOnly: true,
                                    onTap: () => _sendCode(authController),
                                    decoration: InputDecoration(
                                      prefixIcon: Padding(
                                        padding: EdgeInsets.only(left: Dimensions.width30),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            !isOnData ?
                                            Text(
                                              "send code",
                                              style: TextStyle(
                                                color: isOnData
                                                    ? Colors.grey
                                                    : Colors.red,
                                                fontWeight: FontWeight.bold,
                                                fontSize: isOnData
                                                    ? 13.sp : Dimensions.font16,
                                              ),
                                            ) : Container(),
                                            SizedBox(width: Dimensions.width10),
                                            isOnData
                                                ? Text(
                                                    "$_current s",
                                                    style: TextStyle(
                                                      color: Colors.red,
                                                      fontSize: 13,
                                                    ),
                                                  )
                                                : Container(),
                                          ],
                                        ),
                                      ),
                                      // hintText: "send code",
                                      // hintStyle: TextStyle(
                                      //   color:
                                      //       isOnData ? Colors.grey : Colors.red,
                                      //   fontWeight: FontWeight.bold,
                                      //   fontSize: Dimensions.font16,
                                      // ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          width: 1.sp,
                                          color: Colors.white,
                                        ),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          width: 1.sp,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                // child: Container(
                                //   height: 70,
                                //   alignment: Alignment.center,
                                //   decoration: BoxDecoration(
                                //     color: Colors.white,
                                //     // color: Colors.grey[300],
                                //     borderRadius: BorderRadius.only(
                                //           topRight:
                                //               Radius.circular(Dimensions.radius15),
                                //           bottomRight:
                                //               Radius.circular(Dimensions.radius15),
                                //         ),
                                //     boxShadow: [
                                //       BoxShadow(
                                //         blurRadius: 3,
                                //         spreadRadius: 1,
                                //         offset: const Offset(1, 1),
                                //         color: Colors.grey.withOpacity(0.2),
                                //       ),
                                //     ],
                                //   ),
                                //   child: GestureDetector(
                                //         onTap: () => _sendCode(authController),
                                //         child: Row(
                                //           mainAxisSize: MainAxisSize.min,
                                //           children: [
                                //             Text(
                                //               "send code",
                                //               style: TextStyle(
                                //                 color: isOnData
                                //                     ? Colors.grey
                                //                     : Colors.red,
                                //                     fontWeight: FontWeight.bold,
                                //                     fontSize: Dimensions.font16,
                                //               ),
                                //             ),
                                //             SizedBox(width: Dimensions.width10),
                                //             isOnData
                                //                 ? Text(
                                //                     "$_current",
                                //                     style: TextStyle(
                                //                       color: Colors.grey,
                                //                     ),
                                //                   )
                                //                 : Container(),
                                //           ],
                                //         ),
                                //       ),
                                // ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: Dimensions.height20,
                    ),
                    AppTextButton(
                      txt: 'register',
                      onTap: () => _registration(authController),
                    ),

                    SizedBox(
                      height: Dimensions.height10,
                    ),
                    //tag line
                    RichText(
                      text: TextSpan(
                        text: 'Have an account already? ',
                        style: TextStyle(
                          color: Colors.grey[500],
                          fontSize: Dimensions.font20,
                        ),
                        children: [
                          TextSpan(
                            recognizer: TapGestureRecognizer()
                              ..onTap = () => Get.toNamed(Routes.SIGN_IN),
                            text: 'Login',
                            style: TextStyle(
                              color: AppColors.mainBlackColor,
                              fontSize: Dimensions.font20,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: Dimensions.screenHeight * 0.05,
                    ),
                    //sign up options
                    RichText(
                      text: TextSpan(
                        text: 'Sign up using one of the following methods',
                        style: TextStyle(
                          color: Colors.grey[500],
                          fontSize: Dimensions.font16,
                        ),
                      ),
                    ),
                  ],
                ),
              )
            : const CustomLoader(),
      ),
    );
  }
}
