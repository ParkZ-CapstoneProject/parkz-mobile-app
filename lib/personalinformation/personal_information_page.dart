import 'package:flutter/material.dart';
import 'package:parkz/utils/constanst.dart';

import '../utils/text/semi_bold.dart';

class PersonalInformationPage extends StatefulWidget {
  const PersonalInformationPage({Key? key}) : super(key: key);

  @override
  State<PersonalInformationPage> createState() => _PersonalInformationPageState();
}

class _PersonalInformationPageState extends State<PersonalInformationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(color: AppColor.forText),
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: const SemiBoldText(
            text: 'Thông tin cá nhân', fontSize: 20, color: AppColor.forText),
      ),
    );
  }
}
