import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:parkz/utils/text/semi_bold.dart';

class IntroductionBuilder2 extends StatelessWidget {
  const IntroductionBuilder2({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final imageHeight = screenHeight / 3;

    const String background = 'assets/image/splash_2.png';
    const String banner = 'assets/image/splash2.svg';
    const String title = 'Title';
    const String description = 'Lorem ipsum dolor sit amet consectetur. Et molestie arcu massa sagittis ac nam auctor ultricies.';

    return Container(
      decoration: const BoxDecoration(
        image:
            DecorationImage(image: AssetImage(background), fit: BoxFit.cover),
      ),
      child: Column(
        children: [
          const SizedBox(height: 150.0),
          SvgPicture.asset(
            banner,
            fit: BoxFit.fitHeight,
            height: imageHeight,
          ),
          const SizedBox(height: 50.0),
          const SemiBoldText(text: title, fontSize: 24, color: Colors.white),
          const Padding(
            padding: EdgeInsets.only(top: 20.0, right: 50, left: 50),
            child: Text(
              description,
              style: TextStyle(color: Colors.white, fontSize: 14),
              textAlign: TextAlign.center,
            ),
          )
        ],
      ),
    );
  }
}
