import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:i18n_extension/i18n_widget.dart';

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
