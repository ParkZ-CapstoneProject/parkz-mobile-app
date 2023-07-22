import 'package:flutter/material.dart';
import 'package:parkz/account/component/profile_pic.dart';
import 'package:parkz/network/api.dart';
import 'package:parkz/utils/text/regular.dart';
import 'package:parkz/utils/text/semi_bold.dart';

import '../../model/profile_response.dart';

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
      child: FutureBuilder<ProfileResponse?>(
          future: getProfile(context),
          builder: (context, snapshot) {
            if (snapshot.hasData &&
                snapshot.connectionState == ConnectionState.done) {
              if (snapshot.data!.data != null) {
                return Padding(
                padding: const EdgeInsets.only(top: 30.0, bottom: 45),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox(height: 20,),
                    ProfilePic(
                      ava: snapshot.data!.data!.avatar,
                    ),
                    Column(
                      children: [
                        SemiBoldText(
                            text: snapshot.data!.data!.name!,
                            fontSize: 20,
                            color: Colors.white),
                        const SizedBox(
                          height: 15,
                        ),
                        RegularText(
                            text: snapshot.data!.data!.phone!, fontSize: 16, color: Colors.white)
                      ],
                    ),
                  ],
                ),
                );
              } else {
                return const Padding(
                  padding: EdgeInsets.only(top: 30.0, bottom: 45),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      ProfilePic(),
                      Column(
                        children: [
                          SemiBoldText(
                              text: ' - - - - - - - -',
                              fontSize: 20,
                              color: Colors.white),
                          SizedBox(
                            height: 15,
                          ),
                          RegularText(
                              text: '- - - -', fontSize: 16, color: Colors.white)
                        ],
                      ),
                    ],
                  ),
                );
              }
            }
            return const Padding(
              padding: EdgeInsets.only(top: 30.0, bottom: 45),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  ProfilePic(),
                  Column(
                    children: [
                      SemiBoldText(
                          text: ' - - - - - - - -',
                          fontSize: 20,
                          color: Colors.white),
                      SizedBox(
                        height: 15,
                      ),
                      RegularText(
                          text: '- - - -', fontSize: 16, color: Colors.white)
                    ],
                  ),
                ],
              ),
            );
          }),
    );
  }
}
