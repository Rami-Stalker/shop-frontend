import 'package:i18n_extension/i18n_extension.dart';

const loginHello = 'loginHello';
const yourClass = 'yourClass';
const recommendClass = 'recommendClass';

extension Localization on String {
  static final _t = Translations.from("en_us", {
    loginHello: {
      "en_us": "Hello",
      "ar_sa": "مرحبا",
    },
    yourClass: {
      "en_us": "Lớp học của bạn",
      "ar_sa": "Lớp học của bạn",
    },
    recommendClass: {
      "en_us": "Lớp học đề xuất",
      "ar_sa": "Lớp học đề xuất",
    }
  });

  String get i18n => localize(this, _t);

  String fill(List<Object> params) => localizeFill(this, params);

  String plural(int value) => localizePlural(value, this, _t);

  String version(Object modifier) => localizeVersion(modifier, this, _t);
}
