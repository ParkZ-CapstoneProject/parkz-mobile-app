import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:lottie/lottie.dart';
import 'package:parkz/introduction/introduction_page.dart';
import 'package:parkz/utils/constanst.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      backgroundColor: AppColor.navy,
      splashIconSize: 350,
      duration: 4000,
        splash: Lottie.asset('assets/logo/data.json'),
        nextScreen: const IntroductionPage(),
    );
  }
}
