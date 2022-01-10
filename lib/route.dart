import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jjmoney/page/page_home.dart';
import 'package:jjmoney/page/page_result.dart';

class Routers {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    dynamic arguments = settings.arguments;

    switch (settings.name) {
      case 'PageHome':
        return CupertinoPageRoute(
          builder: (_) => PageHome(),
          settings: settings,
        );

      case 'PageResult':
        return CupertinoPageRoute(
          builder: (_) => PageResult(
            resultCounter: arguments,
          ),
          settings: settings,
        );

      default:
        return CupertinoPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('${settings.name} 는 lib/route.dart에 정의 되지 않았습니다.'),
            ),
          ),
        );
    }
  }

  static loadMain(BuildContext context) {
    Navigator.of(context).pushNamedAndRemoveUntil('PageTabs', (route) => false);
    // if (Singleton.shared.userData!.user!.agreeTerms == true) {
    //   Navigator.of(context)
    //       .pushNamedAndRemoveUntil('PageTabs', (route) => false);
    // } else {
    //   Navigator.of(context).pushNamedAndRemoveUntil(
    //     'PageAgreement',
    //     (route) => false,
    //     arguments: true,
    //   );
    // }
  }
}
