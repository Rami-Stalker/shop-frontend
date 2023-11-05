import 'package:shop_app/src/public/constants.dart';

import '../../../routes/app_pages.dart';
import '../controllers/auth_controller.dart';

import '../../../public/components.dart';
import '../../../core/widgets/app_text_button.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/widgets/app_text_field.dart';
import '../../../core/widgets/custom_loader.dart';
import '../../../themes/app_colors.dart';
import '../../../utils/sizer_custom/sizer.dart';

class LoginView extends StatefulWidget {
  final VoidCallback? toggleView;

  LoginView({this.toggleView});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    void _login(AuthController authController) async {
      String email = _emailController.text.trim();
      String password = _passwordController.text.trim();

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
                          backgroundColor: colorPrimary,
                          radius: 50.sp,
                          child: Image.asset(AppConstants.LOGO64_ASSET),
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
                          // Text(
                          //   loginHello.i18n,
                          //   style: Theme.of(context).textTheme.displayMedium,
                          // ),
                          // Text(
                          //   loginDis.i18n,
                          //   style: Theme.of(context)
                          //       .textTheme
                          //       .titleLarge!
                          //       .copyWith(color: fCL),
                          // ),
                        ],
                      ),
                    ),
                    SizedBox(height: 40.sp),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.sp),
                      child: //email
                          AppTextField(
                        keyboardType: TextInputType.emailAddress,
                        textController: _emailController,
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
                          textController: _passwordController,
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
                        // RichText(
                        //   text: TextSpan(
                        //     text: loginAccount.i18n,
                        //     style: Theme.of(context)
                        //         .textTheme
                        //         .titleLarge!
                        //         .copyWith(color: fCL),
                        //   ),
                        // ),
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
                              ..onTap = () => AppNavigator.replaceWith(AppRoutes.REGISTER),
                            text: 'Register',
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
                  ],
                ),
              )
            : const CustomLoader(),
      ),
    );
  }
}
