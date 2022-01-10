import 'package:flutter/cupertino.dart';

class ProviderUserInfo extends ChangeNotifier {
  List<bool> userInfo = [];
  void getUserInfo() {
    notifyListeners();
  }
}
