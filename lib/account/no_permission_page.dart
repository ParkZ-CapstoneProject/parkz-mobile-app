import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../authentication/authentication_page.dart';
import '../utils/button/button_widget.dart';
import '../utils/constanst.dart';
import '../utils/text/medium.dart';
import '../utils/text/semi_bold.dart';

class NoPermissionPage extends StatelessWidget {
  const NoPermissionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: SafeArea(
        child: ListView(
          children: [
            const SizedBox(height: 26,),
            Padding(
              padding: const EdgeInsets.only(left: 28.0),
              child: Lottie.asset('assets/json/inactiveuser/data.json'),
            ),
            const SizedBox(height: 26,),
            const SemiBoldText(text: 'Bạn chưa đăng nhập', color: Colors.black, fontSize: 32, align: TextAlign.center, maxLine: 2),
            const SizedBox(height: 8,),
            const SizedBox(
              width: 320,
              child: MediumText(text: 'Đăng nhập để có thể trải nghiệm tất cả dịch vụ ', color: Colors.blueGrey, fontSize: 12, align: TextAlign.center),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(left: 62.0, right: 62.0, top: 30),
                child: SizedBox(
                    width: double.infinity,
                    child: MyButton(
                      text: 'Đăng nhập',
                      textColor: AppColor.navyPale, backgroundColor: AppColor.navy,
                      function: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) =>  const AuthenticationPage()),
                        );
                      },)
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
