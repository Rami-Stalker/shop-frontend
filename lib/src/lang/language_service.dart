import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:i18n_extension/i18n_widget.dart';

class LanguageService {
  final _getStorage = GetStorage();
  final storageKey = 'locale';

  String getLocale() {
    return _getStorage.read(storageKey) ?? 'ar_vn';
  }

  Future<void> saveLocale(String locale) async {
    await _getStorage.write(storageKey, locale);
  }

  switchLanguage(context) async {
    await saveLocale(((I18n.localeStr == "ar_vn") ? "en_us" : "ar_vn"));
    I18n.of(context).locale =
        (I18n.localeStr == "ar_vn") ? null : const Locale("ar", "VN");
  }

  initialLanguage(context) {
    String localeStr = getLocale();
    if (localeStr == "ar_vn") {
      I18n.of(context).locale = Locale("ar", "VN");
    } else {
      I18n.of(context).locale = null;
    }
  }
}
