import 'dart:convert';
import 'dart:ui';

import 'components.dart';

import 'package:http/http.dart' as http;

class Constants {
  static const INCH_TO_DP = 160;

  // Assets
  static const IMG_PATH = 'assets/images';
  static const PERSON_ASSET = "$IMG_PATH/person.jpg";
  static const MOBILES_ASSET = '$IMG_PATH/mobiles.png';
  static const ESSENTIALS_ASSET = '$IMG_PATH/essentials.jpg';
  static const APPLIANCES_ASSET = '$IMG_PATH/appliances.jpg';
  static const BOOKS_ASSET = '$IMG_PATH/books.jpg';
  static const FASHION_ASSET = '$IMG_PATH/fashion.webp';
  static const EMPTY_ASSET = '$IMG_PATH/empty-box.png';
  static const PAYPAL_ASSET = '$IMG_PATH/paypal-delivery.png';
  static const CASH_ASSET = '$IMG_PATH/cash-delivery.png';

  static const List<String> carouselImages = [
    'https://images-eu.ssl-images-amazon.com/images/G/31/img21/Wireless/WLA/TS/D37847648_Accessories_savingdays_Jan22_Cat_PC_1500.jpg',
    'https://images-eu.ssl-images-amazon.com/images/G/31/img2021/Vday/bwl/English.jpg',
    'https://images-eu.ssl-images-amazon.com/images/G/31/img22/Wireless/AdvantagePrime/BAU/14thJan/D37196025_IN_WL_AdvantageJustforPrime_Jan_Mob_ingress-banner_1242x450.jpg',
    'https://images-na.ssl-images-amazon.com/images/G/31/Symbol/2020/00NEW/1242_450Banners/PL31_copy._CB432483346_.jpg',
    'https://images-na.ssl-images-amazon.com/images/G/31/img21/shoes/September/SSW/pc-header._CB641971330_.jpg',
  ];

  static List<Map<String, String>> categoryImages = [
    {
      'title': 'Mobiles',
      'image': MOBILES_ASSET,
    },
    {
      'title': 'Essentials',
      'image': ESSENTIALS_ASSET,
    },
    {
      'title': 'Appliances',
      'image': APPLIANCES_ASSET,
    },
    {
      'title': 'Books',
      'image': BOOKS_ASSET,
    },
    {
      'title': 'Fashion',
      'image': FASHION_ASSET,
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

  static httpErrorHandle({
  required http.Response res,
  required VoidCallback onSuccess,
}) {
  switch (res.statusCode) {
    case 200:
      onSuccess();
      break;
    case 400:
    Components.showSnackBar(jsonDecode(res.body)['msg']);
    break;
    case 500:
    Components.showSnackBar(jsonDecode(res.body)['error']);
    break;
    default:
    Components.showSnackBar(title: 'successfull',jsonDecode(res.body)['error']);
  }
}
}
