import 'package:flutter/material.dart';
import 'package:parkz/account/account_profile.dart';
import 'package:parkz/account/no_permission_page.dart';


import '../network/api.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  State<AccountPage> createState() => _AccountPageState();
}



class _AccountPageState extends State<AccountPage> {
  String? _token;
  void getToken() async {
    String? token = await storage.read(key: 'token');
    setState(() {
      _token = token;
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    getToken();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    debugPrint('User Token: + $_token');
    if(_token != null){
      return const AccountProfile();
    }
    return const NoPermissionPage();
  }
}

