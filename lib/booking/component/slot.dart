import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:parkz/utils/constanst.dart';
import 'package:parkz/utils/text/regular.dart';
import 'package:parkz/utils/text/semi_bold.dart';

class Slot extends StatefulWidget {
  final int srow;
  final int scell;
  final String name;
  final int slotId;
  final int isBooked;
  final bool isSelected;
  const Slot(
      {Key? key,
      required this.isSelected,
      required this.slotId,
      required this.isBooked,
      required this.srow,
      required this.scell,
      required this.name})
      : super(key: key);

  @override
  State<Slot> createState() => _SlotState();
}

class _SlotState extends State<Slot> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        widget.isSelected == true && widget.isBooked == 0
            ? Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [
                  const Color(0xFFFF8F18),
                  const Color(0xFFFF8F18).withOpacity(0.65),
                  const Color(0xFFFF9423).withOpacity(0.5),
                  const Color(0xFFFF9423).withOpacity(0.4),
                  const Color(0xFFFF9423).withOpacity(0.2),
                ])),
              )
            : Container(),
        Container(
            padding: const EdgeInsets.all(8),
            height: 120,
            width: 140,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                widget.isBooked == 1
                    ? SvgPicture.asset('assets/icon/car_slot.svg',
                        height: 55, width: 114)
                    : widget.isBooked == 2
                        ? const Center(
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.warning,
                                  color: AppColor.orange,
                                  size: 50,
                                ),
                                SizedBox(height: 8,),
                                SemiBoldText(
                                    text: 'Đang bảo trì',
                                    fontSize: 15,
                                    color: AppColor.orange),
                                SizedBox(height: 8,),
                              ],
                            ),
                        )
                        : const SizedBox(
                            height: 55,
                            width: 114,
                          ),
                widget.isBooked != 2 ? SemiBoldText(
                    text: widget.name,
                    fontSize: 15,
                    color: AppColor.forText,
                    align: TextAlign.right) : const SizedBox.shrink(),
                widget.isBooked != 2 ? RegularText(
                    text: 'Hàng ${widget.srow + 1}, Cột ${widget.scell + 1}',
                    color: AppColor.forText,
                    fontSize: 12) : const SizedBox.shrink(),
              ],
            )),
      ],
    );
  }
}
