import 'package:flutter/material.dart';
import 'package:parkz/utils/constanst.dart';
import 'package:parkz/utils/text/semi_bold.dart';

class ParkingDetailPage extends StatefulWidget {
  const ParkingDetailPage({Key? key}) : super(key: key);

  @override
  State<ParkingDetailPage> createState() => _ParkingDetailPageState();
}

class _ParkingDetailPageState extends State<ParkingDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        bottomOpacity: 0.0,
        elevation: 0.0,
        leading: const BackButton(
            color: AppColor.forText
        ),
        backgroundColor: Colors.white,
        title: const SemiBoldText(text: 'Chi tiết bãi xe', fontSize: 20, color: AppColor.forText),
      ),
      body: const Center(
        child: Text('Chi tiết bãi xe'),
      ),
    );
  }
}
