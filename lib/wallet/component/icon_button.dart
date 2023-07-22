import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:parkz/utils/text/medium.dart';

class CustomButton extends StatelessWidget {
  final String icon;
  final String title;
  final Color backgroundColor;
  final Color textColor;


  const CustomButton(
      {super.key,
      required this.icon,
      required this.title,
      required this.backgroundColor,
      required this.textColor,
      });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 53,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
        color: backgroundColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(icon, height: 28, width: 35),
          const SizedBox(width: 8),
          MediumText(text: title, fontSize: 15, color: textColor)
        ],
      ),
    );
  }
}
