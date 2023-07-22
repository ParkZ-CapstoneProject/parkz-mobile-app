import 'package:flutter/material.dart';
import 'package:parkz/utils/text/semi_bold.dart';

import '../../utils/constanst.dart';

class ProfileMenu extends StatelessWidget {
  final String textData;
  final Widget? page;
  final IconData iconData;


  const ProfileMenu({Key? key, required this.textData, this.page, required this.iconData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: page != null ? () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) =>  page!),
          );
      } : null,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SizedBox(
          width: double.infinity,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 18.0),
                      child: Icon(iconData, color: AppColor.navy,)
                    ),
                    SemiBoldText(text: textData, fontSize: 16, color: AppColor.forText)
                  ]
              ),
              const Icon(
                Icons.arrow_forward_ios_rounded,
                color: AppColor.navy,
                size: 20,
              )

            ],
          ),
        ),
      ),
    );
  }
}
