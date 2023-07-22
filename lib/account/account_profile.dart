import 'package:flutter/material.dart';
import 'package:parkz/account/component/profile_body.dart';

import '../utils/text/semi_bold.dart';

class AccountProfile extends StatelessWidget {
  const AccountProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: const SemiBoldText(
            text: 'Tài khoản', fontSize: 20, color: Colors.white),
      ),
      body: const ProfileBody(),
    );
  }
}
