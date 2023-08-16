import 'dart:async';

import 'package:flutter/material.dart';

import '../../bottombar/bottombar_page.dart';
import '../../network/api.dart';
import '../../utils/constanst.dart';
import '../../utils/text/semi_bold.dart';

class CountDownButton extends StatefulWidget {
  final int bookingId;
  const CountDownButton({Key? key, required this.bookingId}) : super(key: key);

  @override
  State<CountDownButton> createState() => _CountDownButtonState();
}

class _CountDownButtonState extends State<CountDownButton> {
  bool isVisible = true;
  int countdown = 10;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (countdown > 0) {
        setState(() {
          countdown--;
        });
      } else {
        timer.cancel();
        setState(() {
          isVisible = false;
        });
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: isVisible,
      child: Expanded(
          child: Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 16.0),
            child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: AppColor.orange, width: 2),
                  shape:  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50.0),
                  ),
                ),
                onPressed: () {
                  cancelBooking(widget.bookingId, context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>  const MyBottomBar(selectedInit: 0,)),
                  );
                },
                child:   SemiBoldText(text: 'Hủy đơn ${countdown}s', fontSize: 13, color: Colors.white)
            ),
          )
      ),
    );
  }
}
