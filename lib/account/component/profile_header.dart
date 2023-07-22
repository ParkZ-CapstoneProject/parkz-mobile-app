import 'package:flutter/material.dart';
import 'package:parkz/account/component/profile_pic.dart';
import 'package:parkz/utils/text/regular.dart';
import 'package:parkz/utils/text/semi_bold.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height / 2.4,
      decoration: const BoxDecoration(
        gradient: LinearGradient(colors: [
          Color(0xFF064789),
          Color(0xFF023B72),
          Color(0xFF022F5B),
          Color(0xFF032445)
        ], begin: Alignment.topLeft, end: Alignment.bottomRight),
      ),
      child: const Padding(
        padding: EdgeInsets.only(top: 30.0, bottom: 45),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(height: 20,),
            ProfilePic(isEdited: false,),
            Column(
              children: [
                SemiBoldText(text: 'Trần Ngọc Thắng', fontSize: 20, color: Colors.white),
                SizedBox(height: 15,),
                RegularText(text: '0773834602', fontSize: 16, color: Colors.white)
              ],
            ),

          ],
        ),
      ),
    );
  }
}
