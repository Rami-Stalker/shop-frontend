import '../controllers/auth_controller.dart';

import '../../../public/components.dart';
import '../../../core/widgets/app_text_button.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/widgets/app_text_field.dart';
import '../../../core/widgets/custom_loader.dart';
import '../../../routes/app_pages.dart';
import '../../../themes/app_colors.dart';
import '../../../utils/sizer_custom/sizer.dart';

class LoginView extends GetView<AuthController> {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    void _login(AuthController authController) async {
      String email = controller.emailC.text.trim();
      String password = controller.passwordC.text.trim();

      if (email.isEmpty) {
        Components.showSnackBar(
          'Type in your email address',
          title: 'Email address',
        );
      } else if (!GetUtils.isEmail(email)) {
        Components.showSnackBar(
          'Type in a valid email address',
          title: 'Valid email address',
        );
      } else if (password.isEmpty) {
        Components.showSnackBar(
          'Type in your password',
          title: 'password',
        );
      } else if (password.length < 6) {
        Components.showSnackBar(
          'Password can not less than six characters',
          title: 'password',
        );
      } else {
        authController.login(email, password);
      }
    }

    return Scaffold(
      body: GetBuilder<AuthController>(
        builder: (authController) => !authController.isLoading
            ? SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    SizedBox(
                      height: SizerUtil.height * 0.05,
                    ),
                    //app logo
                    SizedBox(
                      height: 120.sp,
                      child: Center(
                        child: CircleAvatar(
                          backgroundColor: mCL,
                          radius: 120.sp,
                          backgroundImage: AssetImage("assets/images/logo.png"),
                        ),
                      ),
                    ),
                    SizedBox(height: 30.sp),
                    //welcome
                    Container(
                      margin: EdgeInsets.only(left: 20.sp),
                      width: double.maxFinite,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Hello',
                            style: Theme.of(context).textTheme.displayMedium,
                          ),
                          Text(
                            "An application that contains everything you desire",
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge!
                                .copyWith(color: fCL),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 40.sp),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.sp),
                      child: //email
                          AppTextField(
                        keyboardType: TextInputType.emailAddress,
                        textController: controller.emailC,
                        hintText: 'email',
                        icon: Icons.email,
                      ),
                    ),
                    SizedBox(height: 10.sp),
                    //password
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.sp),
                      child: GetBuilder<AuthController>(
                          builder: (loginController) {
                        return AppTextField(
                          textController: loginController.passwordC,
                          hintText: 'password',
                          icon: Icons.password,
                          isObscure: loginController.isObscure,
                          suffixIcon: InkWell(
                            onTap: () {
                              loginController.changeObsure();
                            },
                            child: Icon(
                              loginController.isObscure
                                  ? Icons.visibility_outlined
                                  : Icons.visibility_off_outlined,
                              color: colorPrimary,
                            ),
                          ),
                        );
                      }),
                    ),
                    SizedBox(height: 20.sp),
                    //tag line
                    Row(
                      children: [
                        Expanded(
                          child: Container(),
                        ),
                        RichText(
                          text: TextSpan(
                            text: 'Sign into your account',
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge!
                                .copyWith(color: fCL),
                          ),
                        ),
                        SizedBox(
                          width: 20.sp,
                        ),
                      ],
                    ),
                    SizedBox(height: 60.sp),
                    AppTextButton(
                      txt: 'Login',
                      onTap: () {
                        _login(authController);
                      },
                    ),
                    SizedBox(
                      height: SizerUtil.height * 0.05,
                    ),
                    //tag line
                    RichText(
                      text: TextSpan(
                        text: 'Don\'t an account? ',
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge!
                            .copyWith(color: fCL),
                        children: [
                          TextSpan(
                            recognizer: TapGestureRecognizer()
                              ..onTap = () => AppNavigator.replaceWith(Routes.REGISTER),
                            text: 'create',
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
                  ],
                ),
              )
            : const CustomLoader(),
      ),
    );
  }
}
