import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../utils/text/regular.dart';
import '../../utils/text/semi_bold.dart';

class VehicleSelected extends StatelessWidget {
  final String vehicleName;
  final String licensePlate;
  final String color;
  final Function()? function;
  const VehicleSelected({Key? key, required this.vehicleName, required this.licensePlate, required this.color, this.function}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: double.infinity,
        height: 86,
        decoration: BoxDecoration(
          image: const DecorationImage(
            image: AssetImage('assets/image/car_selected_bg.png'),
            fit: BoxFit.cover,
          ),
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [
                  const SizedBox(width: 8),
                  SvgPicture.asset('assets/icon/car.svg', height: 45, width: 45),
                  const SizedBox(width: 26),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SemiBoldText(text: vehicleName,color: Colors.white,fontSize: 16),
                      const SizedBox(height: 8),
                      RegularText(text: licensePlate, fontSize: 14, color: Colors.white),
                      RegularText(text: color, fontSize: 14, color: Colors.white)
                    ],
                  ),
                ],
              ),


              IconButton(onPressed: function, icon: const Icon(Icons.close, size: 30, color: Colors.white,))

            ],
          ),
        ),
      ),
    );
  }
}
