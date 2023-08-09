import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:parkz/activity/component/status_tag.dart';
import 'package:parkz/utils/constanst.dart';
import 'package:parkz/utils/text/regular.dart';
import 'package:parkz/utils/text/semi_bold.dart';

import '../../booking/booking_page.dart';

class ActivityCard extends StatefulWidget {
  final int bookingId;
  final DateTime dateBook;
  final DateTime startTime;
  final DateTime endTime;
  final String licensePlate;
  final String address;
  final String parkingName;
  final String floorName;
  final String slotName;
  final String status;
  final bool? isRating;


  const ActivityCard({Key? key, required this.bookingId, required this.dateBook, required this.startTime, required this.endTime, required this.licensePlate, required this.address, required this.parkingName, required this.floorName, required this.slotName, required this.status, this.isRating}) : super(key: key);

  @override
  State<ActivityCard> createState() => _ActivityCardState();
}

class _ActivityCardState extends State<ActivityCard> {

  @override
  Widget build(BuildContext context) {

    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>  BookingPage(bookingId: widget.bookingId,)),
        );
      },
      child: Stack(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            height: 170,
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
                        SvgPicture.asset('assets/icon/car.svg',
                          width: 40,
                          height: 40,
                        ),
                        const SizedBox(width: 16),
                         Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            RegularText(text: 'Mã đơn ${widget.bookingId}', fontSize: 12, color: AppColor.forText),
                            const SizedBox(width: 90,),
                            RegularText(
                              text: widget.licensePlate,
                              color: AppColor.forText,
                              fontSize: 13,
                            ),
                            const SizedBox(height: 5,),
                            SizedBox(
                              height: 27,
                              child: Row(
                                children: [
                                  SemiBoldText(
                                      text: DateFormat('dd/MM/yyyy').format(widget.dateBook),
                                      color: AppColor.forText,
                                      fontSize: 15),
                                  const VerticalDivider(
                                      thickness: 1,
                                      color: AppColor.forText,
                                      endIndent: 6,
                                      indent: 6),
                                  SemiBoldText(
                                      text: '${DateFormat('HH:mm').format(widget.startTime)} - ${DateFormat('HH:mm').format(widget.endTime)}',
                                      color: AppColor.forText,
                                      fontSize: 15),
                                ],
                              ),
                            ),
                          ],
                        ),

                      ],
                    ),

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
                      SemiBoldText(text: widget.address,fontSize: 15, color: AppColor.forText),
                      const SizedBox(height: 8),
                      RegularText(text: '${widget.parkingName} : ${widget.floorName} - ${widget.slotName}', fontSize: 13, color: AppColor.forText)
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 12,
              right: 12,
              child: StatusTag(status: widget.status, isRating: widget.isRating,)

          )
        ],
      ),
    );
  }
}
