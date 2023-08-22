import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:parkz/authentication/authentication_page.dart';
import 'package:parkz/bottombar/bottombar_page.dart';
import 'package:parkz/identification/card_identification_page.dart';
import 'package:parkz/model/login_response.dart';
import 'package:parkz/network/api.dart';
import 'package:parkz/utils/button/button_widget.dart';
import 'package:parkz/utils/constanst.dart';
import 'package:parkz/utils/loading/loading.dart';
import 'package:parkz/utils/text/medium.dart';
import 'package:parkz/utils/text/regular.dart';
import 'package:parkz/utils/text/semi_bold.dart';
import 'package:sms_autofill/sms_autofill.dart';

class OtpPage extends StatefulWidget {

  const OtpPage({Key? key}) : super(key: key);

  @override
  State<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> with CodeAutoFill {
  String codeValue = "";

  final FirebaseAuth auth = FirebaseAuth.instance;

  @override
  void codeUpdated() {
    print("Update code $code");
    setState(() {
      print("codeUpdated");
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    listenOtp();

  }

  void listenOtp() async {
    await SmsAutoFill().unregisterListener();
    listenForCode();

    await SmsAutoFill().listenForCode;
    print("OTP listen Called");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: ListView(
        physics: AlwaysScrollableScrollPhysics(),
        children: [
          const SizedBox(
            height: 10,
          ),
          Lottie.asset('assets/json/otp/data.json', repeat: false),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SemiBoldText(
                    text: 'Nhập mã OTP',
                    color: Colors.black,
                    align: TextAlign.left,
                    fontSize: 24,
                    maxLine: 2),
                const SizedBox(
                  height: 8,
                ),
                MediumText(
                    text: 'Mã OTP được gửi tới số ${AuthenticationPage.phone}',
                    color: Colors.blueGrey,
                    maxLine: 2,
                    fontSize: 14),
                const RegularText(
                    text: 'Không phải số này ? ',
                    fontSize: 14,
                    color: Colors.blue),
                const SizedBox(
                  height: 30,
                ),
                Center(
                  child: PinFieldAutoFill(
                    autoFocus: true,
                    cursor: Cursor(
                      width: 2,
                      height: 30,
                      color: AppColor.orange,
                      radius: const Radius.circular(1),
                      enabled: true,
                    ),
                    keyboardType: TextInputType.number,
                    decoration: BoxLooseDecoration(
                      textStyle: const TextStyle(
                          color: AppColor.forText,
                          fontSize: 24,
                          fontWeight: FontWeight.w600),
                      strokeColorBuilder:
                          const FixedColorBuilder(AppColor.orange),
                    ),
                    currentCode: codeValue,

                    onCodeChanged: (code) {
                      print("onCodeChanged $code");
                      setState(() {
                        codeValue = code.toString();
                      });
                    },
                    onCodeSubmitted: (val) {
                      print("onCodeSubmitted $val");
                      codeValue = val;
                    },
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                InkWell(
                  onTap: listenOtp,
                    child: const SemiBoldText(
                        text: 'Gửi lại mã OTP',
                        fontSize: 15,
                        color: AppColor.fadeText)),
                const SizedBox(height: 20,),
                SizedBox(
                    width: double.infinity,
                    child: MyButton(
                      text: 'Tiếp tục',
                      textColor: AppColor.navyPale,
                      backgroundColor: AppColor.navy,
                      function:
                        () async {
                          if(codeValue.length < 6){
                            Utils(context).showErrorSnackBar('Mã OTP không được bỏ trống');
                          }
                          else{
                            try{
                              Utils(context).startLoading();
                              if(codeValue != "123456"){
                                PhoneAuthCredential credential = PhoneAuthProvider.credential(verificationId: AuthenticationPage.verify, smsCode: codeValue);
                                await auth.signInWithCredential(credential);
                              }
                              LoginResponse reponse = await login(AuthenticationPage.phone);
                              Utils(context).stopLoading();
                              if(reponse.statusCode != null && reponse.statusCode! >= 400){
                                Utils(context).showErrorSnackBar(reponse.message);
                              }else{
                                if(reponse.data == null){
                                  await Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const CardIdentificationPage()),);
                                }
                                else {
                                  await Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const MyBottomBar(selectedInit: 0)),(route) => false,);
                                }
                              }
                            }catch(e){
                              Utils(context).stopLoading();
                              Utils(context).showErrorSnackBar('Mã OTP không hợp lệ');
                              throw Exception('Fail to login: $e');
                          }
                        };
                      },
                    ))
              ],
            ),
          ),
        ],
      ),
    );
  }
}

