import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:parkz/utils/button/button_widget.dart';
import 'package:parkz/utils/constanst.dart';
import 'package:parkz/utils/text/medium.dart';
import 'package:parkz/utils/text/semi_bold.dart';

class OtpPage extends StatefulWidget {
  const OtpPage({Key? key}) : super(key: key);

  @override
  State<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  final List<FocusNode> _focusNodes = [
    FocusNode(),
    FocusNode(),
    FocusNode(),
    FocusNode(),
    FocusNode(),
    FocusNode(),
  ];

  final TextEditingController _firstController = TextEditingController();
  final TextEditingController _secondController = TextEditingController();
  final TextEditingController _thirdController = TextEditingController();
  final TextEditingController _fourthController = TextEditingController();
  final TextEditingController _fifthController = TextEditingController();
  final TextEditingController _sixthController = TextEditingController();
  @override
  void dispose() {
    _firstController.dispose();
    _secondController.dispose();
    _thirdController.dispose();
    _fourthController.dispose();
    _fifthController.dispose();
    _sixthController.dispose();
    super.dispose();
  }

  Widget _buildOtpBox(int position, FocusNode focusNode) {
    TextEditingController? controller;
    switch (position) {
      case 1:
        controller = _firstController;
        break;
      case 2:
        controller = _secondController;
        break;
      case 3:
        controller = _thirdController;
        break;
      case 4:
        controller = _fourthController;
        break;
      case 5:
        controller = _fifthController;
        break;
      case 6:
        controller = _sixthController;
        break;
    }

    return Expanded(
      child: TextFormField(
        controller: controller,
        focusNode: focusNode,
        keyboardType: TextInputType.number,
        maxLength: 1,
        textAlign: TextAlign.center,
        style: const TextStyle(fontSize: 17),
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.only(bottom: 5, left: 4),
          counter: const Offstage(),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Colors.orange, width: 2),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Colors.orange, width: 2),
          ),
        ),
        onChanged: (value) {
          if (value.length == 1) {
            focusNode.nextFocus();
          }
        },
      ),
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
          Lottie.asset('assets/json/otp/data.json', repeat: false),
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
                          text: 'Nhập mã OTP',
                          color: Colors.black,
                          align: TextAlign.left,
                          fontSize: 20,
                          maxLine: 2),
                      SizedBox(height: 8,),
                      MediumText(
                          text: 'Mã OTP được gửi tới số 0773834602',
                          color: Colors.blueGrey,
                          maxLine: 2,
                          fontSize: 12),
                    ],
                  ),
                  const SizedBox(height: 30,),
                  SizedBox(
                    height: 48,
                    child: Row(
                      children: [
                        _buildOtpBox(1, _focusNodes[0]),
                        const SizedBox(width: 16),
                        _buildOtpBox(2, _focusNodes[1]),
                        const SizedBox(width: 16),
                        _buildOtpBox(3, _focusNodes[2]),
                        const SizedBox(width: 16),
                        _buildOtpBox(4, _focusNodes[3]),
                        const SizedBox(width: 16),
                        _buildOtpBox(5, _focusNodes[4]),
                        const SizedBox(width: 16),
                        _buildOtpBox(6, _focusNodes[5]),
                      ],
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
