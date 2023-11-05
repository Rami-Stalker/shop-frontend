import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_app/src/core/widgets/app_text.dart';
import 'package:shop_app/src/lang/language_service.dart';
import 'package:shop_app/src/modules/language/widgets/language_widget.dart';
import 'package:shop_app/src/public/constants.dart';
import 'package:shop_app/src/themes/app_colors.dart';
import 'package:shop_app/src/themes/font_family.dart';

class LanguageView extends StatelessWidget {
  const LanguageView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GetBuilder<LocalizationController>(
            builder: (localizationController) {
          return Column(
            children: [
              Expanded(
                child: Center(
                  child: Scrollbar(
                    child: SingleChildScrollView(
                      physics: BouncingScrollPhysics(),
                      padding: EdgeInsets.all(5),
                      child: Center(
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Center(
                                child: Image.asset(
                                  AppConstants.LOGO64_ASSET,
                                  width: 120,
                                ),
                              ),
                              SizedBox(height: 5),
                              Center(
                                child: Text(
                                  'The Best Food',
                                  style: TextStyle(
                                    color: colorPrimary,
                                    fontFamily: FontFamily.allison,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                              SizedBox(height: 30),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                child: AppText('select_language'.tr),
                              ),
                              SizedBox(height: 10),
                              GridView.builder(
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  childAspectRatio: 1,
                                ),
                                itemCount: 2,
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemBuilder: (context, index) =>
                                  LanguageWidget(
                                    languageModel:
                                        localizationController.languages[index],
                                    localizationController:
                                        localizationController,
                                    index: index,
                                  ),
                              ),
                              SizedBox(height: 10),
                              AppText('you_can_change_language'.tr),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}
