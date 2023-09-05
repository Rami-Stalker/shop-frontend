import 'dart:io';

import 'package:shop_app/src/modules/auth/controllers/auth_controller.dart';
import '../../../controller/app_controller.dart';
import '../../../core/dialogs/dialog_loading.dart';
import '../../../public/constants.dart';
import '../../../themes/app_colors.dart';
import '../../../utils/blurhash.dart';
import '../../../utils/sizer_custom/sizer.dart';

import '../../../helpers/picker/custom_image_picker.dart';
import '../../../public/components.dart';
import '../../../core/widgets/app_text_button.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/widgets/app_text_field.dart';
import '../../../core/widgets/custom_loader.dart';
import '../../../routes/app_pages.dart';
import 'package:country_picker/country_picker.dart';
import 'package:quiver/async.dart';

import '../../../themes/app_decorations.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  TextEditingController emailTextController = TextEditingController();
  TextEditingController passwordTextController = TextEditingController();
  TextEditingController nameTextController = TextEditingController();
  TextEditingController phoneTextController = TextEditingController();
  TextEditingController codeOtpTextController = TextEditingController();

  @override
  void dispose() {
    emailTextController.dispose();
    passwordTextController.dispose();
    nameTextController.dispose();
    phoneTextController.dispose();
    codeOtpTextController.dispose();
    super.dispose();
  }

  File? _image;

  Country? countryCode;

  void _pickCountry() {
    showCountryPicker(
      context: context,
      showPhoneCode: true,
      countryListTheme: CountryListThemeData(
        bottomSheetHeight: SizerUtil.height - 300,
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
    String phoneNumber = phoneTextController.text.trim();

    if (!isOnData) {
      if (phoneNumber.isNotEmpty) {
        startTimer();
        authController.sendOtP(
          phoneCode: countryCode!.phoneCode,
          phoneNumber: '${phoneTextController.text.trim()}',
        );
      } else {
        Components.showSnackBar(
          'Type your number until sent to you code OTP',
          title: 'Code OTP',
        );
      }
    }
  }

  void _registration(AuthController authController) {
    String email = emailTextController.text.trim();
    String password = passwordTextController.text.trim();
    String name = nameTextController.text.trim();
    String phoneNumber = phoneTextController.text.trim();
    String codeOTP = codeOtpTextController.text.trim();

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
        avatar: _image,
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
      body: GetBuilder<AuthController>(
        builder: (authController) => !authController.isLoading
            ? SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    SizedBox(height: 30.sp),
                    //app logo
                    SizedBox(
                        height: 120.sp,
                        width: SizerUtil.height,
                        child: GestureDetector(
                  onTap: () {
                    CustomImagePicker().openImagePicker(
                      context: context,
                      handleFinish: (File image) async {
                        showDialogLoading(context);
                        AppGet.authGet.updateAvatar(avatar: image);
                      },
                    );
                  },
                  child: Container(
                    width: 100.w,
                    alignment: Alignment.center,
                    child: Container(
                      height: 105.sp,
                      width: 105.sp,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: colorPrimary,
                          width: 3.sp,
                        ),
                      ),
                      alignment: Alignment.center,
                      child: Container(
                        height: 95.sp,
                        width: 95.sp,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(1000.sp),
                          child: BlurHash(
                            hash: '',
                            image: Constants.urlImageDefault,
                            imageFit: BoxFit.cover,
                            color: colorPrimary,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
                    // SizedBox(
                    //   height: 120.sp,
                    //   child: GestureDetector(
                    //     onTap: () {
                    //       CustomImagePicker().openImagePicker(
                    //         context: context,
                    //         handleFinish: (File image) async {
                    //           setState(() {
                    //             _image = image;
                    //           });
                    //         },
                    //       );
                    //     },
                    //     child: Container(
                    //       decoration: BoxDecoration(
                    //         shape: BoxShape.circle,
                    //         border: Border.all(
                    //           color: colorPrimary,
                    //           width: 1.5.sp,
                    //         ),
                    //         // borderRadius: BorderRadius.circular(6.sp),
                    //         image: _image != null
                    //             ? DecorationImage(
                    //                 image: FileImage(_image!),
                    //                 fit: BoxFit.fill,
                    //               )
                    //             : DecorationImage(
                    //                 image: AssetImage(Constants.PERSON_ASSET),
                    //                 fit: BoxFit.contain,
                    //               ),
                    //       ),
                    //       alignment: Alignment.center,
                    //       child: Icon(
                    //         PhosphorIcons.plusCircle,
                    //         color: colorPrimary,
                    //         size: 30.sp,
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    SizedBox(height: 30.sp),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.sp),
                      child: Column(
                        children: [
                          //name
                          AppTextField(
                            textController: nameTextController,
                            hintText: 'name',
                            icon: Icons.person,
                          ),
                          SizedBox(height: 10.sp),
                          //email
                          AppTextField(
                            keyboardType: TextInputType.emailAddress,
                            textController: emailTextController,
                            hintText: 'email',
                            icon: Icons.email,
                          ),
                          SizedBox(height: 10.sp),

                          //password
                          GetBuilder<AuthController>(builder: (authController) {
                            return AppTextField(
                              textController: passwordTextController,
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
                                child: _containerWidget(
                                  isRight: false,
                                  isLeft: true,
                                  child: TextField(
                                    onTap: _pickCountry,
                                    readOnly: true,
                                    cursorColor: colorPrimary,
                                    decoration: InputDecoration(
                                      hintText:
                                          '+ ${countryCode != null ? countryCode!.phoneCode : "1"}',
                                      hintStyle: TextStyle(fontSize: 12),
                                      prefixIcon: Icon(
                                        Icons.phone,
                                        color: colorMedium,
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
                                flex: 3,
                                child: _containerWidget(
                                  isRight: true,
                                  isLeft: false,
                                  child: TextField(
                                    keyboardType: TextInputType.number,
                                    controller: phoneTextController,
                                    cursorColor: colorMedium,
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
                                  isRight: false,
                                  isLeft: true,
                                  child: TextField(
                                    keyboardType: TextInputType.number,
                                    controller: codeOtpTextController,
                                    cursorColor: colorMedium,
                                    decoration: InputDecoration(
                                      hintText: "verification code",
                                      prefixIcon: Icon(
                                        Icons.timer_sharp,
                                        color: colorMedium,
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
                                child: _containerWidget(
                                  isRight: true,
                                  isLeft: false,
                                  child: TextField(
                                    keyboardType: TextInputType.number,
                                    readOnly: true,
                                    onTap: () => _sendCode(authController),
                                    decoration: InputDecoration(
                                      prefixIcon: Padding(
                                        padding: EdgeInsets.only(
                                          left: 15.sp,
                                        ),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            !isOnData
                                                ? Expanded(
                                                    child: Text(
                                                      "send code",
                                                      style: TextStyle(
                                                        color: isOnData
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
                        ],
                      ),
                    ),
                    SizedBox(height: 20.sp),

                    AppTextButton(
                      txt: 'register',
                      onTap: () => _registration(authController),
                    ),

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
                              ..onTap = () => AppNavigator.replaceWith(Routes.LOGIN),
                            text: 'login',
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge!
                                .copyWith(color: Colors.blue),
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
            : const CustomLoader(),
      ),
    );
  }

  Container _containerWidget({
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
