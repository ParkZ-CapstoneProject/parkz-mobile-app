import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:parkz/otp/otp_page.dart';
import 'package:parkz/utils/constanst.dart';
import 'package:parkz/utils/text/medium.dart';
import 'package:parkz/utils/text/semi_bold.dart';

import '../utils/button/button_widget.dart';

class AuthenticationPage extends StatefulWidget {
  const AuthenticationPage({Key? key}) : super(key: key);

  @override
  State<AuthenticationPage> createState() => _AuthenticationPageState();
}

class _AuthenticationPageState extends State<AuthenticationPage> {
  @override
  Widget build(BuildContext context) {
    final TextEditingController _phoneNumberController = TextEditingController();

    return Scaffold(
      body: ListView(
        children: [
          const SizedBox(
            height: 20,
          ),
          Lottie.asset('assets/json/register/data.json', reverse: true),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: SizedBox(
              height: MediaQuery.of(context).size.height - 500,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children:  const [
                      SemiBoldText(
                          text: 'Nhập số điện thoại để tiếp tục ',
                          color: Colors.black,
                          align: TextAlign.left,
                          fontSize: 20,
                          maxLine: 2),
                      SizedBox(height: 2,),
                      MediumText(
                          text: 'Nếu số điện thoại của bạn không có trong hệ thống,\n chúng tôi sẽ ghi nhận tài khoản mới cho bạn.',
                          color: Colors.blueGrey,
                          maxLine: 2,
                          fontSize: 12),
                    ],
                  ),
                  TextField(
                    controller: _phoneNumberController,
                    keyboardType: TextInputType.phone,
                    decoration: const InputDecoration(
                      hintText: 'Nhập số điện thoại',
                      hintStyle: TextStyle(color: AppColor.navy,fontWeight: FontWeight.w600, ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: AppColor.orange),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: AppColor.orange),
                      ),
                    ),
                  ),



                  const SizedBox(height: 40,),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: SizedBox(
                        width: double.infinity,
                        child: MyButton(
                          text: 'Tiếp tục',
                          textColor: AppColor.navyPale,
                          backgroundColor: AppColor.navy,
                          function: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>  const OtpPage()),
                            );
                          },
                        )),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
