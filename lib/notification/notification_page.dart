import 'package:flutter/material.dart';
import 'package:parkz/notification/component/notification_card.dart';
import 'package:parkz/utils/constanst.dart';
import 'package:parkz/utils/text/semi_bold.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({Key? key}) : super(key: key);

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: AppColor.navyPale,
      appBar: AppBar(
        bottomOpacity: 0.0,
        elevation: 0.0,
        leading: const BackButton(
            color: AppColor.forText
        ),
        backgroundColor: Colors.white,
        title: const SemiBoldText(text: 'Thông báo', fontSize: 20, color: AppColor.forText),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.only(top: 10,bottom: 20, left: 15, right: 15),
        itemBuilder: (context, index) {
          return const Padding(
            padding: EdgeInsets.only(top: 8.0),
            child: NotificationCard(),
          );
        },
        itemCount: 5,
      ),
    );
  }
}
