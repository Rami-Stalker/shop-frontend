import 'package:flutter/material.dart';
import 'package:shop_app/src/core/widgets/app_text.dart';

import 'package:shop_app/src/lang/language_service.dart';
import 'package:shop_app/src/models/language_model.dart';
import 'package:shop_app/src/public/constants.dart';
import 'package:shop_app/src/themes/app_colors.dart';

class LanguageWidget extends StatelessWidget {
  final LanguageModel languageModel;
  final LocalizationController localizationController;
  final int index;
  const LanguageWidget({
    Key? key,
    required this.languageModel,
    required this.localizationController,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        localizationController.setLanguage(
          Locale(
            AppConstants.languages[index].languageCode,
            AppConstants.languages[index].countryCode,
          ),
        );
        localizationController.setSelectIndex(index);
      },
      child: Container(
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey[200]!,
              blurRadius: 5,
              spreadRadius: 1,
            ),
          ],
        ),
        child: Stack(
          children: [
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(height: 5),
                  AppText(languageModel.languageName),
                ],
              ),
            ),
            localizationController.selectedIndex == index
                ? Positioned(
                    top: 0.0,
                    right: 0.0,
                    left: 0.0,
                    bottom: 40,
                    child: Icon(
                      Icons.check_circle,
                      color: colorPrimary,
                      size: 25,
                    ),
                  )
                : SizedBox(),
          ],
        ),
      ),
    );
  }
}
