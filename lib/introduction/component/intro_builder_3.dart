import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:parkz/utils/constanst.dart';
import 'package:parkz/utils/text/semi_bold.dart';

class IntroductionBuilder3 extends StatelessWidget {
  const IntroductionBuilder3({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final imageHeight = screenHeight / 2.3;

    const String banner = 'assets/image/splash3.svg';
    const String title = 'ParkZ';
    const String description =
        'Nền tảng kết nối giữa người dùng và bãi xe, dễ dàng đặt chỗ, kiếm chỗ tiết kiệm thời gian. \n Ra vào bãi bằng QR ra vào bãi dễ dàng và nhanh chóng ';

    return Container(
      decoration: const BoxDecoration(
        // image:
        //     DecorationImage(image: AssetImage(background), fit: BoxFit.cover),
        gradient: LinearGradient(colors: [
          AppColor.fadeText,
          AppColor.navy,

        ],
            begin: Alignment.bottomCenter,
            end: Alignment.centerRight
        ),
      ),
      child: Column(
        children: [
          const SizedBox(height: 100.0),
          SvgPicture.asset(
            banner,
            fit: BoxFit.fitHeight,
            height: imageHeight,
          ),
          const SizedBox(height: 20.0),
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
