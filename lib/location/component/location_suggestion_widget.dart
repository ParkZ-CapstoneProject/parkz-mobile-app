import 'package:flutter/material.dart';
import 'package:parkz/utils/constanst.dart';

import '../../utils/text/regular.dart';
import '../../utils/text/semi_bold.dart';

class LocationSuggestionWidget extends StatelessWidget {
  final String address;
  final Function()? function;
  const LocationSuggestionWidget({Key? key, required this.address,  this.function}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    int commaIndex = address.indexOf(',');
    String title = address.substring(0, commaIndex).trim();
    String subtitle = address.substring(commaIndex + 1).trim();

    return ListTile(
      leading:  Container(
        width: 50, // Adjust the size as desired
        height: 50,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: AppColor.navyPale,
        ),
        child: const Icon(
          Icons.location_on_rounded,
          color: AppColor.navy,
          size: 25, // Adjust the icon size as desired
        ),
      ),
      title:  SemiBoldText(text:title,fontSize: 14, color: AppColor.forText),
      subtitle:  RegularText(text: subtitle, fontSize: 11, color: AppColor.forText,maxLine: 2, ),
      onTap: function,
    );
  }
}
