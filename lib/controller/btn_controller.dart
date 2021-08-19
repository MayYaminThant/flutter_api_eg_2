import 'package:flutter/cupertino.dart';

enum ButtonName { POST, COMMENT }

class ButtonController with ChangeNotifier {
  ButtonController(this._btnName);
  String _btnName;

  String get btnName => this._btnName;

  set btnName(String name) {
    if (name == _btnName) {
      return;
    }

    _btnName = name;
    notifyListeners();
  }
}
