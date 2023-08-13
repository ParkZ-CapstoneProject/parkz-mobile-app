import 'package:flutter/material.dart';

class CountdownButtonProvider extends ChangeNotifier {
  Map<int, CountdownButton> countdownButtons = {};

  void addButton(int id) {
    if (!countdownButtons.containsKey(id)) {
      countdownButtons[id] = CountdownButton(id);
      notifyListeners();
    }
  }

  CountdownButton getButton(int id) {
    if (countdownButtons.containsKey(id)) {
      return countdownButtons[id]!;
    }
    return CountdownButton(id);
  }
}

class CountdownButton {
  final int id;
  bool isButtonDisabled;
  int countdown;

  CountdownButton(this.id)
      : isButtonDisabled = false,
        countdown = 0;

  void startCountdown() {
    isButtonDisabled = true;
    countdown = 10;

    Future.doWhile(() async {
      await Future.delayed(Duration(seconds: 1));
      countdown--;

      if (countdown <= 0) {
        isButtonDisabled = false;
        return false;
      }

      return true;
    });
  }
}
