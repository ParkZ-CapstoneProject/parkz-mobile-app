import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:parkz/activity/component/status_tag.dart';
import 'package:parkz/utils/constanst.dart';
import 'package:parkz/utils/text/regular.dart';
import 'package:parkz/utils/text/semi_bold.dart';

class ActivityCard extends StatefulWidget {
  const ActivityCard({Key? key}) : super(key: key);

  @override
  State<ActivityCard> createState() => _ActivityCardState();
}

class _ActivityCardState extends State<ActivityCard> {

  @override
  Widget build(BuildContext context) {

    return Container(
      padding: const EdgeInsets.all(8),
      height: 136,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Big Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const SizedBox(width: 16),
                  SvgPicture.asset(
                    'assets/icon/car.svg',
                    width: 30,
                    height: 30,
                  ),
                  const SizedBox(width: 16),
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 27,
                        child: Row(
                          children: [
                            SemiBoldText(
                                text: '19/04/2023',
                                color: AppColor.forText,
                                fontSize: 15),
                            VerticalDivider(
                                thickness: 1,
                                color: AppColor.forText,
                                endIndent: 6,
                                indent: 6),
                            SemiBoldText(
                                text: '14:00', color: AppColor.forText, fontSize: 15),


                          ],
                        ),
                      ),
                      SizedBox(height: 5,),

                      RegularText(
                        text: 'KIA / 75A-165.19',
                        color: AppColor.forText,
                        fontSize: 13,
                      ),

                    ],
                  ),
                ],
              ),


              const StatusTag()
            ],
          ),
          const Divider(
              thickness: 1,
              color: AppColor.fadeText,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SemiBoldText(text: 'Takashimaya - 94 Nam Kỳ Khởi Nghĩa ',fontSize: 15, color: AppColor.forText),
                SizedBox(height: 8),
                RegularText(text: 'Parking : B3 - Cột A3.5', fontSize: 13, color: AppColor.forText)
              ],
            ),
          ),
        ],
      ),
    );
  }
}
