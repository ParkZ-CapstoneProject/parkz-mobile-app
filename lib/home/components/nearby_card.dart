import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:parkz/parkingdetail/parking_detail_page.dart';
import 'package:parkz/utils/constanst.dart';
import 'package:parkz/utils/text/regular.dart';
import 'package:parkz/utils/text/semi_bold.dart';
import 'package:intl/intl.dart';

class NearByCard extends StatefulWidget {
  final String title;
  final String? imagePath;
  final double? rating;
  final double? carPrice;
  final double? motoPrice;
  final double distance;
  final String address;
  final bool isPrepayment;
  final bool isOvernight;
  final int id;

  const NearByCard(
      {Key? key,
      required this.title,
       this.imagePath,
       this.rating,
       this.carPrice,
      required this.address,
      required this.id,
      this.motoPrice,
      required this.isPrepayment,
      required this.isOvernight, required this.distance,
      })
      : super(key: key);

  @override
  State<NearByCard> createState() => _NearByCardState();
}

class _NearByCardState extends State<NearByCard> {
  final List<String> tagName = ['Trả trước', 'Trả sau', 'Qua đêm'];

  @override
  Widget build(BuildContext context) {
    List<String> tagNameBuilder = [];
    if (widget.isPrepayment == true) {
      tagNameBuilder.add(tagName[0]);
    } else {
      tagNameBuilder.add(tagName[1]);
    }
    if (widget.isOvernight == true) {
      tagNameBuilder.add(tagName[2]);
    }

    String parkingTagName = tagNameBuilder.join(' I ');

    return Padding(
      padding: const EdgeInsets.only(bottom: 26, right: 8.0, left: 8, top: 16),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) =>  ParkingDetailPage(id: widget.id,)),
          );
        },
        child: Container(
          width: 254,
          decoration: BoxDecoration(boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ], color: Colors.white, borderRadius: BorderRadius.circular(7.0)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              widget.imagePath != null
                  ? ClipRRect(
                      borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(7.0),
                          topLeft: Radius.circular(7.0)),
                      child: Image.network(
                        widget.imagePath!,
                        fit: BoxFit.cover,
                        height: 120,
                        width: 254,
                      ),
                    )
                  : ClipRRect(
                      borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(7.0),
                          topLeft: Radius.circular(7.0)),
                      child: Container(
                        height: 120,
                        width: 254,
                        color: Colors.grey,
                        child: const Center(child: Icon(Icons.photo)),
                      ),
                    ),

              // Phần body của card
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                child: SizedBox(
                  width: 230,
                  height: 140,
                  child: Stack(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Rating and distance
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                               RegularText(
                                  text: 'Cách ${double.parse(widget.distance.toStringAsFixed(1))} km',
                                  fontSize: 13,
                                  color: AppColor.navy),

                              widget.rating != null
                                  ? Row(
                                      children: [
                                        RegularText(
                                            text: widget.rating.toString(),
                                            fontSize: 13,
                                            color: AppColor.forText),
                                        const Icon(
                                          Icons.star_rounded,
                                          color: AppColor.orange,
                                          size: 20,
                                        )
                                      ],
                                    )
                                  : const SizedBox(),
                            ],
                          ),

                          const SizedBox(
                            height: 4,
                          ),
                          //Title
                          SizedBox(
                              width: 180,
                              child: SemiBoldText(
                                  text: widget.title,
                                  fontSize: 15,
                                  color: AppColor.forText)),
                          const SizedBox(
                            height: 4,
                          ),
                          // Địa chỉ
                          SizedBox(
                            width: 250,
                            child: RegularText(
                                text: widget.address,
                                fontSize: 13,
                                color: AppColor.forText,
                                maxLine: 2),
                          ),
                          const SizedBox(
                            height: 8,
                          ),

                          // Tag
                          RegularText(
                              text: parkingTagName,
                              fontSize: 13,
                              color: AppColor.orange)
                        ],
                      ),
                      Positioned(
                        top: 110,
                        width: 225,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            widget.carPrice != null
                                ? Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      SvgPicture.asset('assets/icon/car.svg',
                                          width: 20, height: 16),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: SemiBoldText(
                                            text:
                                                '${NumberFormat('#,###').format(widget.carPrice?.toInt()).replaceAll(',', '.')}đ',
                                            fontSize: 15,
                                            color: AppColor.forText),
                                      ),
                                    ],
                                  )
                                : const SizedBox(),
                            widget.motoPrice != null
                                ? Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      SvgPicture.asset('assets/icon/bike.svg',
                                          width: 20, height: 16),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: SemiBoldText(
                                            text:
                                                '${NumberFormat('#,###').format(widget.carPrice?.toInt()).replaceAll(',', '.')}đ',
                                            fontSize: 15,
                                            color: AppColor.forText),
                                      ),
                                    ],
                                  )
                                : const SizedBox()
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
