import 'dart:io';

import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdMobService {
  String? getInterstitialAdId() {
    if (Platform.isIOS) {
      return 'ca-app-pub-9695790043722201~3359475487'; // 내꺼
      // return 'ca-app-pub-3940256099942544/4411468910'; // test광고
    } else if (Platform.isAndroid) {
      // my admob
      return "ca-app-pub-9695790043722201/2846476456"; // 내꺼
      // return 'ca-app-pub-3940256099942544/1033173712'; //test 광고
    }
    return null;
  }
}
