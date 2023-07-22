import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:parkz/account/component/profile_header.dart';
import 'package:parkz/account/component/profile_menu.dart';
import 'package:parkz/bottombar/bottombar_page.dart';
import 'package:parkz/personalinformation/personal_information_page.dart';
import 'package:parkz/vehicle/vehicle_page.dart';
import 'package:parkz/wallet/wallet_page.dart';

import '../../network/api.dart';

class ProfileBody extends StatelessWidget {
  const ProfileBody({Key? key}) : super(key: key);

  void logout(BuildContext context)  {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.warning,
      animType: AnimType.bottomSlide,
      title: 'Đăng xuất',
      desc: 'Bạn có chắc chắn muốn đăng xuất?',
      btnCancelOnPress: () {},
      btnOkOnPress: () {
        storage.delete(key: 'token');
        storage.delete(key: 'userID');
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const MyBottomBar(selectedInit: 0)),);
      },
    ).show();
  }

  @override
  Widget build(BuildContext context) {
    return  SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(
            height: 18,
          ),
          const ProfileHeader(),
          const ProfileMenu(iconData: Icons.person, textData: 'Thông tin cá nhân', page: PersonalInformationPage()),
          const Divider(
            height: 8,
          ),
          const ProfileMenu(
              iconData: Icons.directions_car_sharp,
              textData: 'Quản lý phương tiện',
              page: VehiclePage(isSelected: false,)),
          const Divider(
            height: 8,
          ),
          const ProfileMenu(iconData: Icons.wallet, textData: 'Ví thanh toán', page: WalletPage()),
          const Divider(
            height: 8,
          ),
          const ProfileMenu(iconData: Icons.support_agent, textData: 'Hỗ trợ'),
          const Divider(
            height: 8,
          ),
          GestureDetector(child: const ProfileMenu(iconData: Icons.login_outlined, textData: 'Đăng xuất',), onTap: (){logout(context);}),
        ],
      ),
    );
  }
}
