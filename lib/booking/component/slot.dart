import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:parkz/utils/constanst.dart';
import 'package:parkz/utils/text/regular.dart';

class Slot extends StatefulWidget {
  final int index;
  final int cellIndex;
  final bool isSelected;
  const Slot({Key? key, required this.index, required this.cellIndex, required this.isSelected}) : super(key: key);

  @override
  State<Slot> createState() => _SlotState();
}

class _SlotState extends State<Slot> {
  @override
  Widget build(BuildContext context) {
    return  Stack(
      children: [
        widget.isSelected ?
        Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
                const Color(0xFFFF8F18),
                const Color(0xFFFF8F18).withOpacity(0.65),
                const Color(0xFFFF9423).withOpacity(0.5),
                const Color(0xFFFF9423).withOpacity(0.4),
                const Color(0xFFFF9423).withOpacity(0.2),
              ]
              )
          ),
        ):
        Container()
        ,
        Container(
            padding: const EdgeInsets.all(8),
            height: 119,
            width: 140,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                widget.index.isOdd ? SvgPicture.asset('assets/icon/car_slot.svg', height: 55, width: 114) : Container() ,
                RegularText(text: 'Row ${widget.index + 1}, Cell ${widget.cellIndex + 1}', color: AppColor.forText, fontSize: 13),
              ],
            )
        ),
      ],
    );
  }
}
