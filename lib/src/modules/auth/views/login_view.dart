import 'package:shop_app/src/modules/auth/controllers/auth_controller.dart';

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
    

    void _login(AuthController authCtrl) {
      String email = controller.emailIC.text.trim();
      String password = controller.passwordIC.text.trim();

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
        authCtrl.signInUser(email, password);
      }
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: GetBuilder<AuthController>(
        builder: (authCtrl) => !authCtrl.isLoading
            ? SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    SizedBox(
                      height: Dimensions.screenHeight * 0.05,
                    ),
                    //app logo
                    SizedBox(
                      height: Dimensions.screenHeight * 0.25,
                      child: Center(
                        child: CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 100,
                          backgroundImage: AssetImage("assets/images/logo.png"),
                        ),
                      ),
                    ),
                    //welcome
                    Container(
                      margin: EdgeInsets.only(left: Dimensions.width20),
                      width: double.maxFinite,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Hello',
                            style: TextStyle(
                              fontSize:
                                  130.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'Sign into your account',
                            style: TextStyle(
                              fontSize: Dimensions.font20,
                              color: Colors.grey[500],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: Dimensions.height20,
                    ),
                    Padding(
                    padding: EdgeInsets.symmetric(horizontal: Dimensions.width20),
                    child: //email
                    AppTextField(
                      keyboardType: TextInputType.emailAddress,
                      textController: controller.emailIC,
                      hintText: 'email',
                      icon: Icons.email,
                    ),
                    ),
                    SizedBox(
                      height: Dimensions.height20,
                    ),
                    //password
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: Dimensions.width20),
                      child: GetBuilder<AuthController>(builder: (authCtrl) {
                        return AppTextField(
                          textController: controller.passwordIC,
                          hintText: 'password',
                          icon: Icons.password,
                          isObscure: authCtrl.isObscure,
                          suffixIcon: InkWell(
                            onTap: () {
                              authCtrl.changeObsure();
                            },
                            child: Icon(
                              authCtrl.isObscure
                                  ? Icons.visibility_outlined
                                  : Icons.visibility_off_outlined,
                              color: colorPrimary,
                            ),
                          ),
                        );
                      }),
                    ),
                    SizedBox(
                      height: Dimensions.height20,
                    ),
                    //tag line
                    Row(
                      children: [
                        Expanded(
                          child: Container(),
                        ),
                        RichText(
                          text: TextSpan(
                            text: 'Sign into your account',
                            style: TextStyle(
                              color: Colors.grey[500],
                              fontSize: Dimensions.font20,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: Dimensions.width20,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: Dimensions.screenHeight * 0.05,
                    ),
                    AppTextButton(
                        txt: 'Login',
                        onTap: () {
                          _login(authCtrl);
                        },
                      ),
                    SizedBox(
                      height: Dimensions.screenHeight * 0.05,
                    ),
                    //tag line
                    RichText(
                      text: TextSpan(
                        text: 'Don\'t an account? ',
                        style: TextStyle(
                          color: Colors.grey[500],
                          fontSize: Dimensions.font20,
                        ),
                        children: [
                          TextSpan(
                            recognizer: TapGestureRecognizer()
                              ..onTap = () => Get.toNamed(Routes.SIGN_UP),
                            text: 'Create',
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: Dimensions.screenHeight * 0.05,
                    ),
                  ],
                ),
              )
            : const CustomLoader(),
      ),
    );
  }
}
