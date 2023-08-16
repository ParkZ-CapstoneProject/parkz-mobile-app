import 'package:flutter/material.dart';

class WarningFlagProvider with ChangeNotifier {
  bool _isWarning = false;

  bool get isWarning => _isWarning;

  void setWarningFlag(bool value) {
    _isWarning = value;
    notifyListeners();
  }
}
