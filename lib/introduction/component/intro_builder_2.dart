import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:parkz/utils/constanst.dart';
import 'package:parkz/utils/text/semi_bold.dart';

class IntroductionBuilder2 extends StatelessWidget {
  const IntroductionBuilder2({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final imageHeight = screenHeight / 3;

    const String banner = 'assets/image/splash2.svg';
    const String title = 'Giải pháp';
    const String description = 'ParkZ ở đây để giải quyết vấn đ đó cho bạn.\n Môt nền tảng giúp bạn có thể dễ dàng tìm kiếm bãi đỗ xe ô tô gần địa điểm mà bạn muốn đến. ';

    return Container(
      decoration:   const BoxDecoration(
        // image:
        //     DecorationImage(image: AssetImage(background), fit: BoxFit.cover),
        gradient: LinearGradient(colors: [
          AppColor.navy,
          AppColor.forText
        ],
          begin: Alignment.bottomLeft,
            end: Alignment.bottomRight
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
