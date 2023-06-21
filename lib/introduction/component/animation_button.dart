import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:parkz/bottombar/bottombar_page.dart';
import 'package:parkz/utils/constanst.dart';
import 'package:parkz/utils/text/semi_bold.dart';

class AnimationButton extends StatefulWidget {
  final bool onFinalPage;

  const AnimationButton({Key? key, required this.onFinalPage}) : super(key: key);

  @override
  State<AnimationButton> createState() => _AnimationButtonState();
}

class _AnimationButtonState extends State<AnimationButton> {
  bool _showButton = false;
  @override
  void initState() {
    super.initState();
    if (widget.onFinalPage) {
      // Show the button after a delay
      Future.delayed(const Duration(milliseconds: 500), () {
        setState(() {
          _showButton = true;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          alignment: Alignment.bottomCenter,
          child: Lottie.asset('assets/json/pixel/data.json'),
        ),
        Positioned(
          right: MediaQuery.of(context).size.width / 2 - 100,
          bottom: 125,
          left: MediaQuery.of(context).size.width / 2 - 100,
          child: AnimatedOpacity(
            opacity: _showButton ? 1.0 : 0.0,
            duration: const Duration(milliseconds: 500),
            child: ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) =>  const MyBottomBar(selectedInit: 0)),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColor.navyPale,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50.0),
                ),
                minimumSize: const Size(150.0, 42.0),
              ),
              child:const SemiBoldText(text: 'Hoàn thành', fontSize: 13, color: AppColor.navy),
            ),
          ),
        ),
      ],
    );
  }
}
