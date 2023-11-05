import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:i18n_extension/i18n_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop_app/src/models/language_model.dart';
import 'package:shop_app/src/public/constants.dart';

class LanguageService {
  final _getStorage = GetStorage();
  final storageKey = 'locale';

  String getLocale() {
    return _getStorage.read(storageKey) ?? 'ar_sa';
  }

  Future<void> saveLocale(String locale) async {
    await _getStorage.write(storageKey, locale);
  }

  switchLanguage(context) async {
    await saveLocale(((I18n.localeStr == "ar_sa") ? "en_us" : "ar_sa"));
    I18n.of(context).locale =
        (I18n.localeStr == "ar_sa") ? null : const Locale("ar", "SA");
  }

  initialLanguage(context) {
    String localeStr = getLocale();
    if (localeStr == "ar_sa") {
      I18n.of(context).locale = Locale("ar", "SA");
    } else {
      I18n.of(context).locale = null;
    }
  }
}

class LocalizationController extends GetxController implements GetxService {
  final SharedPreferences sharedPreferences;
  LocalizationController({required this.sharedPreferences}) {
    loadCurrentLanguage();
  }

  Locale _locale = Locale(
    AppConstants.languages[0].languageCode,
    AppConstants.languages[0].countryCode,
  );
  Locale get locale => _locale;

  int _selectedIndex = 0;
  int get selectedIndex => _selectedIndex;

  List<LanguageModel> _languages = [];
  List<LanguageModel> get languages => _languages;

  void loadCurrentLanguage() async {
    _locale = Locale(
      sharedPreferences.getString(AppConstants.LANGUAGE_CODE) ??
          AppConstants.languages[0].languageCode,
      sharedPreferences.getString(AppConstants.COUNTRY_CODE) ??
          AppConstants.languages[0].countryCode,
    );

    for (int index = 0; index < AppConstants.languages.length; index++) {
      if (AppConstants.languages[index].languageCode == _locale.languageCode) {
        _selectedIndex = index;
        break;
      }
    }

    _languages = [];
    _languages.addAll(AppConstants.languages);
    update();
  }

  void setLanguage(Locale locale) {
    Get.updateLocale(locale);
    _locale = locale;
    saveLanguage(_locale);
    update();
  }

  void setSelectIndex(int index) {
    _selectedIndex = index;
    update();
  }

  void saveLanguage(Locale locale) {
    sharedPreferences.setString(
      AppConstants.LANGUAGE_CODE,
      locale.languageCode,
    );
    sharedPreferences.setString(
      AppConstants.COUNTRY_CODE,
      locale.countryCode!,
    );
  }
}
