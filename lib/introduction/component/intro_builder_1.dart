import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:parkz/utils/constanst.dart';
import 'package:parkz/utils/text/semi_bold.dart';

class IntroductionBuilder1 extends StatelessWidget {
  const IntroductionBuilder1({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final imageHeight = screenHeight / 3;

    const String banner = 'assets/image/splash1.svg';
    const String title = 'Title';
    const String description =
        'Lorem ipsum dolor sit amet consectetur. Et molestie arcu massa sagittis ac nam auctor ultricies.';

    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(colors: [
          AppColor.navy,
          AppColor.forText
        ],
        ),
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
