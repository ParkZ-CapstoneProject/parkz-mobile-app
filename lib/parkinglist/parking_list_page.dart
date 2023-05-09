import 'package:flutter/material.dart';
import 'package:parkz/utils/constanst.dart';
import 'package:parkz/utils/text/semi_bold.dart';

class ParkingListPage extends StatelessWidget {
  const ParkingListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        bottomOpacity: 0.0,
        elevation: 0.0,
        leading: const BackButton(
            color: AppColor.forText
        ),
        backgroundColor: Colors.white,
        title: const SemiBoldText(text: 'Danh sách bãi xe', fontSize: 20, color: AppColor.forText),
      ),
      body: const Center(child: Text('Parking List')),
    );
  }
}
