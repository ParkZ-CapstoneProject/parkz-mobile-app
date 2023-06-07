import 'package:flutter/material.dart';
import 'package:parkz/utils/constanst.dart';
import 'package:parkz/utils/text/semi_bold.dart';

class VehiclePage extends StatefulWidget {
  const VehiclePage({Key? key}) : super(key: key);

  @override
  State<VehiclePage> createState() => _VehiclePageState();
}

class _VehiclePageState extends State<VehiclePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        bottomOpacity: 0.0,
        elevation: 0.0,
        leading: const BackButton(color: AppColor.forText),
        backgroundColor: Colors.white,
        title: const SemiBoldText(text: 'Quản lý phương tiện', fontSize: 20, color: AppColor.forText),
      ),
    );
  }
}
