import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:parkz/utils/constanst.dart';
import 'package:parkz/utils/text/regular.dart';
import 'package:parkz/utils/text/semi_bold.dart';

class VehicleCard extends StatelessWidget {
  final String vehicleName;
  final String licensePlate;
  final String color;
  const VehicleCard({Key? key, required this.vehicleName, required this.licensePlate, required this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: double.infinity,
        height: 100,
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(width: 26),
              SvgPicture.asset('assets/icon/car.svg', height: 45, width: 45),
              const SizedBox(width: 26),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SemiBoldText(text: vehicleName,color: AppColor.forText,fontSize: 16),
                  const SizedBox(height: 8),
                  RegularText(text: licensePlate, fontSize: 14, color: AppColor.forText),
                  RegularText(text: color, fontSize: 14, color: AppColor.forText)
                ],
              ),

            ],
          ),
        ),
      ),
    );
  }
}
