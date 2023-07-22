import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../utils/constanst.dart';
import '../../utils/text/regular.dart';
import '../../utils/text/semi_bold.dart';

class EmptyBooking extends StatelessWidget {
  const EmptyBooking({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children:  [
        Lottie.asset('assets/json/empty/629-empty-box.json', ),
        const SizedBox(height: 30,),
        const SemiBoldText(text: 'Có vẻ bạn chưa đặt đơn nào.', fontSize: 17, color: AppColor.forText),
        const SizedBox(height: 5,),
        const RegularText(text: 'Tìm bãi xe nhanh chóng và tiện lợi', fontSize: 13, color: AppColor.fadeText),
        const SizedBox(height: 50,),
      ],
    );
  }
}
