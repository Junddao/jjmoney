import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:jjmoney/generated/locale_keys.g.dart';
import 'package:jjmoney/page/page_home.dart';
import 'package:jjmoney/style/colors.dart';
import 'package:jjmoney/style/textstyles.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:jjmoney/util/admob_service.dart';
import 'package:jjmoney/util/service_string_utils.dart';
import 'package:share_plus/share_plus.dart';

class PageResult extends StatefulWidget {
  const PageResult({Key? key, required this.resultCounter}) : super(key: key);

  final int resultCounter;

  @override
  _PageResultState createState() => _PageResultState();
}

class _PageResultState extends State<PageResult> {
  double visibleFlag1 = 0;
  double visibleFlag2 = 0;
  double visibleFlag3 = 0;
  double visibleFlag4 = 0;
  double visibleFlag5 = 0;

  int assets = 0;
  int grade = 0;
  Future<bool>? _isLoading;

  InterstitialAd? _interstitialAd;
  int _numInterstitialLoadAttempts = 0;

  int maxFailedLoadAttempts = 3;

  void _showInterstitialAd() {
    if (_interstitialAd == null) {
      print('Warning: attempt to show interstitial before loaded.');
      return;
    }
    _interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
      onAdDismissedFullScreenContent: (InterstitialAd ad) {
        print('11111111');
        ad.dispose();
        _createInterstitialAd();
      },
      onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError error) {
        print('22222222');
        ad.dispose();
        _createInterstitialAd();
      },
      onAdShowedFullScreenContent: (InterstitialAd ad) => print('333333333'),
    );
    _interstitialAd!.show();
    _interstitialAd = null;
  }

  void _createInterstitialAd() {
    String adId = AdMobService().getInterstitialAdId()!;
    // String adId = 'ca-app-pub-3940256099942544/1033173712';
    InterstitialAd.load(
        adUnitId: adId,
        request: AdRequest(),
        adLoadCallback: InterstitialAdLoadCallback(
          onAdLoaded: (InterstitialAd ad) {
            _interstitialAd = ad;
            _numInterstitialLoadAttempts = 0;
          },
          onAdFailedToLoad: (LoadAdError error) {
            _numInterstitialLoadAttempts += 1;
            _interstitialAd = null;
            if (_numInterstitialLoadAttempts <= maxFailedLoadAttempts) {
              _createInterstitialAd();
            }
          },
        ));
  }

  @override
  void initState() {
    _createInterstitialAd();
    _isLoading = Future.delayed(Duration(seconds: 2), () {
      return false;
    });
    getMyAssets();
    Future.delayed(Duration(milliseconds: 3000), () {
      setState(() {
        visibleFlag1 = 1;
      });
    });
    Future.delayed(Duration(milliseconds: 4000), () {
      setState(() {
        visibleFlag2 = 1;
      });
    });
    Future.delayed(Duration(milliseconds: 5000), () {
      setState(() {
        visibleFlag3 = 1;
      });
    });

    Future.delayed(Duration(milliseconds: 6000), () {
      setState(() {
        visibleFlag5 = 1;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return Future(() => false);
      },
      child: Scaffold(
        // extendBody: true,

        body: SafeArea(child: _body()),
        bottomSheet: FutureBuilder<Object>(
            initialData: true,
            future: _isLoading,
            builder: (context, snapshot) {
              return snapshot.data == true
                  ? SizedBox.shrink()
                  : InkWell(
                      onTap: () {
                        _showInterstitialAd();
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(builder: (context) => PageHome()),
                            (route) => false);
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 18),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: MColors.facebook_blue,
                          ),
                          height: 50,
                          width: double.infinity,
                          child: Center(
                            child: Text(LocaleKeys.retry.tr(),
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18)),
                          ),
                        ),
                      ),
                    );
            }),
      ),
    );
  }

  Widget _body() {
    return FutureBuilder<Object>(
        initialData: true,
        future: _isLoading,
        builder: (context, snapshot) {
          return snapshot.data == true
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      getAniText(),
                    ],
                  ),
                );
        });
  }

  Widget getAniText() {
    return Column(
      children: [
        AnimatedOpacity(
          duration: Duration(milliseconds: 1500),
          opacity: visibleFlag1,
          child: Text(LocaleKeys.assets_message.tr(),
              style: MTextStyles.bold18Black),
        ),
        SizedBox(height: 24),
        AnimatedOpacity(
          duration: Duration(milliseconds: 1500),
          opacity: visibleFlag2,
          child: Text(ServiceStringUtils.won(assets),
              style: MTextStyles.bold18Black),
        ),
        SizedBox(height: 24),
        AnimatedOpacity(
          duration: Duration(milliseconds: 1500),
          opacity: visibleFlag3,
          child: Text(LocaleKeys.result_message1.tr() + '$grade%',
              style: MTextStyles.bold18Black),
        ),
        SizedBox(height: 48),
        AnimatedOpacity(
          duration: Duration(milliseconds: 1500),
          opacity: visibleFlag5,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Colors.teal, // This is what you need!
            ),
            child: Text(LocaleKeys.share.tr()),
            onPressed: () {
              Share.share(LocaleKeys.assets_message.tr() +
                  '$assets' +
                  LocaleKeys.won +
                  ' / ' +
                  LocaleKeys.result_message1.tr() +
                  '$grade%' +
                  ' / ');
            },
          ),
        ),
      ],
    );
  }

  void getMyAssets() {
    if (widget.resultCounter == 3) {
      assets = Random().nextInt(9999) * 10000000;
    } else if (widget.resultCounter == 2) {
      assets = Random().nextInt(999) * 1000000;
    } else if (widget.resultCounter == 1) {
      assets = Random().nextInt(999) * 100000;
    } else {
      assets = Random().nextInt(999) * 10000;
    }

    if (assets > 3000000000) {
      grade = 1;
    } else if (assets > 1000000000 && assets <= 3000000000) {
      grade = 5;
    } else if (assets > 700000000 && assets <= 1000000000) {
      grade = 15;
    } else if (assets > 400000000 && assets <= 700000000) {
      grade = 30;
    } else if (assets > 100000000 && assets <= 400000000) {
      grade = 50;
    } else if (assets > 30000000 && assets <= 100000000) {
      grade = 70;
    } else if (assets > 30000000 && assets <= 30000000) {
      grade = 90;
    } else {
      grade = 95;
    }
  }
}
