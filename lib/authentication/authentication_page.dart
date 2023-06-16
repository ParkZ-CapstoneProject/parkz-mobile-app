import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:parkz/otp/otp_page.dart';
import 'package:parkz/utils/constanst.dart';
import 'package:parkz/utils/loading/loading.dart';
import 'package:parkz/utils/text/medium.dart';
import 'package:parkz/utils/text/semi_bold.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sms_autofill/sms_autofill.dart';

import '../utils/button/button_widget.dart';

class AuthenticationPage extends StatefulWidget {
  const AuthenticationPage({Key? key}) : super(key: key);

  @override
  State<AuthenticationPage> createState() => _AuthenticationPageState();

  static String verify = "";
}

class _AuthenticationPageState extends State<AuthenticationPage> {
  final mobileNumber = TextEditingController();

  @override
  void dispose() {
    mobileNumber.dispose();
    super.dispose();
  }

   submit() async {
    if (mobileNumber.text == "") return;

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('phoneRegister', mobileNumber.text);

    var appSignatureID = await SmsAutoFill().getAppSignature;
    Map sendOtpData = {
      "mobile_number": mobileNumber.text,
      "app_signature_id": appSignatureID
    };
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: '+84 ${mobileNumber.text.substring(1)}',
      verificationCompleted: (PhoneAuthCredential credential) {
        Utils(context).showSuccessSnackBar('Thành công');
      },
      verificationFailed: (FirebaseAuthException e) {
        Utils(context).showErrorSnackBar('Xác thực thất bại' + e.toString());
        print('fail ne: ' + e.toString());
      },
      codeSent: (String verificationId, int? resendToken) {
        AuthenticationPage.verify = verificationId;
        Navigator.push(context, MaterialPageRoute(builder: (context) =>  OtpPage(phone: mobileNumber.text,)),
        );
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        Utils(context).showErrorSnackBar('Xác thực thất bại');
      },
    );

  }

  @override
  Widget build(BuildContext context) {


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
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children:  [
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
                    controller: mobileNumber,
                    keyboardType: TextInputType.number,
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
                          function: submit,
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
