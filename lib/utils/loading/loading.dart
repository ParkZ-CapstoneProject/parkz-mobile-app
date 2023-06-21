import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:parkz/utils/text/medium.dart';
import 'package:parkz/utils/text/semi_bold.dart';

class Utils {
  late BuildContext context;

  Utils(this.context);

  // this is where you would do your fullscreen loading
  Future<void> startLoading() async {
    return await showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return  SimpleDialog(
          elevation: 0.0,
          backgroundColor: Colors.transparent,
          children: <Widget>[
            Center(
              child: Lottie.asset('assets/json/loading/96949-loading-animation.json', height: 180, width: 180),
            )
          ],
        );
      },
    );
  }

  Future<void> stopLoading() async {
    Navigator.of(context).pop();
  }

  void showErrorSnackBar(message){
    Flushbar(
      duration: const Duration(seconds: 3),
      titleText: const SemiBoldText(text: 'Thất bại', fontSize: 15, color: Colors.white, maxLine: 5),
      messageText:  MediumText(text: message, fontSize: 13, color: Colors.white),
      backgroundColor: Colors.red,
      flushbarPosition: FlushbarPosition.TOP,
    ).show(context);
  }

  void showWarningSnackBar(message){
    Flushbar(
      duration: const Duration(seconds: 3),
      titleText: const SemiBoldText(text: 'Cảnh báo', fontSize: 15, color: Colors.white),
      messageText:  MediumText(text: message, fontSize: 13, color: Colors.white),
      backgroundColor: Colors.orangeAccent,
      flushbarPosition: FlushbarPosition.TOP,
    ).show(context);
  }

  void showSuccessSnackBar(message){
    Flushbar(
      duration: const Duration(seconds: 3),
      titleText: const SemiBoldText(text: 'Thành Công', fontSize: 15, color: Colors.white),
      messageText:  MediumText(text: message, fontSize: 13, color: Colors.white),
      backgroundColor: Colors.green,
      flushbarPosition: FlushbarPosition.TOP,
    ).show(context);
  }
}