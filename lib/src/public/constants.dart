import 'dart:convert';
import 'dart:ui';

import 'package:lottie/lottie.dart';
import 'package:shop_app/src/models/language_model.dart';

import 'components.dart';

import 'package:dio/dio.dart' as diox;

class AppConstants {
  static const INCH_TO_DP = 160;

  static String COUNTRY_CODE = 'country_code';
  static String LANGUAGE_CODE = 'language_code';

  static const urlImageDefault = 'assets/icons/logo32.png';

  // Lottie
  static const LOTTIE_PATH = 'assets/lotties';
  LottieBuilder splashLottie = Lottie.asset('$LOTTIE_PATH/splash.json');
  LottieBuilder loadingLottie = Lottie.asset('$LOTTIE_PATH/cat_sleeping.json');
  LottieBuilder loginLottie = Lottie.asset('$LOTTIE_PATH/login.json');

  // Image
  static const IMG_PATH = 'assets/images';
  static const PERSON_ASSET = "$IMG_PATH/person.jpg";
  static const EMPTY_ASSET = '$IMG_PATH/empty-box.png';
  
  static const DRINKS_ASSET = '$IMG_PATH/drinks.jpg';
  static const BREAKFAST_ASSET = '$IMG_PATH/breakfast.jpg';
  static const WRAPS_ASSET = '$IMG_PATH/wraps.jpg';
  static const BRUNCH_ASSET = '$IMG_PATH/brunch.jpg';
  static const BURGERS_ASSET = '$IMG_PATH/burgers.png';
  static const FRUNCHTOAST_ASSET = '$IMG_PATH/frenchToast.jpg';
  static const SIDES_ASSET = '$IMG_PATH/sides.avif';
  static const TOASTEDPANINIS_ASSET = '$IMG_PATH/toastedPaninis.jpg';

  // Icon
  static const ICON_PATH = 'assets/icons';
  static const LOGO32_ASSET = '$ICON_PATH/logo32.png';
  static const LOGO64_ASSET = '$ICON_PATH/logo64.png';
  static const PAYPAL_ASSET = '$ICON_PATH/paypal.png';
  static const CASH_ASSET = '$ICON_PATH/bitcoins.png';

  // Language
  static const LANGUAGE_PATH = 'assets/languages';
  static const IN_LANGUAGE = '$LANGUAGE_PATH/en.json';
  static const AR_LANGUAGE = '$LANGUAGE_PATH/ar.json';

  static const List<String> carouselImages = [
    'https://images-eu.ssl-images-amazon.com/images/G/31/img21/Wireless/WLA/TS/D37847648_Accessories_savingdays_Jan22_Cat_PC_1500.jpg',
    'https://images-eu.ssl-images-amazon.com/images/G/31/img2021/Vday/bwl/English.jpg',
    'https://images-eu.ssl-images-amazon.com/images/G/31/img22/Wireless/AdvantagePrime/BAU/14thJan/D37196025_IN_WL_AdvantageJustforPrime_Jan_Mob_ingress-banner_1242x450.jpg',
    'https://images-na.ssl-images-amazon.com/images/G/31/Symbol/2020/00NEW/1242_450Banners/PL31_copy._CB432483346_.jpg',
    'https://images-na.ssl-images-amazon.com/images/G/31/img21/shoes/September/SSW/pc-header._CB641971330_.jpg',
  ];

  static List<Map<String, String>> categoryImages = [
    {
      'title': 'Drinks',
      'image': DRINKS_ASSET,
    },
    {
      'title': 'Breakfast',
      'image': BREAKFAST_ASSET,
    },
    {
      'title': 'Wraps',
      'image': WRAPS_ASSET,
    },
    {
      'title': 'Brunch',
      'image': BRUNCH_ASSET,
    },
    {
      'title': 'Burgers',
      'image': BURGERS_ASSET,
    },
    {
      'title': 'French Toast',
      'image': FRUNCHTOAST_ASSET,
    },
    {
      'title': 'Sides',
      'image': SIDES_ASSET,
    },
    {
      'title': 'Toasted Paninis',
      'image': TOASTEDPANINIS_ASSET,
    },
  ];

  static final List<Map<String, String>> defaultClassImageUrls = [
    {
      'image':
          'https://i.pinimg.com/originals/02/89/09/02890993e3735184e80ecdf9db079e05.png',
      'blurHash':
          r'rGQ8#*9Z~D%2aL$+t6NHNG%NtQaKRkM_axo#oejF^Sr@I.S1S#S2o0n$WBROWWSyoexbj]nij]W;%Mg2NZV[i_nhWrt7t6xajFjbbbbvbbWAWAkD',
    },
    {
      'image':
          'https://i.pinimg.com/564x/62/de/59/62de59126d9e5b2a72f7ab306ba08dd5.jpg',
      'blurHash':
          r'rGP;+eJC{Lv|:j-:xFNIAJ%hR*Z#xurqRPNHsqO?}v,pOAK6OFSes+r;xVL~S5tQV@K5t7ogbDwH|FR*Ki$$bcI;NIohof==slFMNdnPtRwcV@nh',
    },
    {
      'image':
          'https://i.pinimg.com/564x/44/e7/9a/44e79a4fc1ae11b021629dcdfc68503d.jpg',
      'blurHash':
          r'r9D[S9%J0}#SmmEdAqxH-nyFT0I.s9wJaLslt7t70c$f}HEyKdnUw#brr?eTr=$+Sht2xtJBRiNY-WJ7J~sqVyxoV?VvxZItbGoaoMXAoIw[NHN1',
    },
    {
      'image':
          'https://i.pinimg.com/564x/ba/ab/2b/baab2b85777e2754653d028ee0a30194.jpg',
      'blurHash':
          r'rUR1I?Io}Z-oadNbj[xuWr-pkWRPs9S}NFWVf,n*$NbFNuWBs:oze.r=jrnhoIozR+V]ozf*V?X7xGs:R+R*R*a}oyWUn+a{oIW;R,sVoMn%s.WB',
    },
  ];

  static getOnlyDefaultClassImage() {
    defaultClassImageUrls.shuffle();
    return defaultClassImageUrls.first;
  }

  static const filesSupported = [
    'docx',
    'doc',
    'pdf',
    'pptx',
  ];

  static List<LanguageModel> languages = [
    LanguageModel(
      imageUrl: "en.png",
      languageName: 'English',
      languageCode: 'en',
      countryCode: 'US',
    ),
    LanguageModel(
      imageUrl: "ar.png",
      languageName: 'عربي',
      languageCode: 'ar',
      countryCode: 'SA',
    ),
  ];

  static handleApi({
    required diox.Response response,
    required VoidCallback onSuccess,
  }) {
    switch (response.statusCode) {
      case 200:
        onSuccess();
        break;
      case 400:
        Components.showSnackBar(response.data['msg'], title: "msg");
        break;
      case 500:
        Components.showSnackBar(response.data['error'], title: "error");
        break;
      default:
        Components.showSnackBar(
            title: 'successfull', jsonDecode(response.data)['error']);
    }
  }
}
