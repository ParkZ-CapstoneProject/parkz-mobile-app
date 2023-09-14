import 'package:flutter/material.dart';

class WarningFlagProvider with ChangeNotifier {
  bool _isWarning = false;

  bool get isWarning => _isWarning;

  void setWarningFlag(bool value) {
    _isWarning = value;
    notifyListeners();
  }

   final List<int> _bookingIds = [];

  void addBookingId(int id) {
    if (!_bookingIds.contains(id)) {
      _bookingIds.add(id);
      notifyListeners();
    }
  }

  void removeBookingId(int id) {
    _bookingIds.remove(id);
    notifyListeners();
  }

  bool containsBookingId(int id) {
    return _bookingIds.contains(id);
  }


}
