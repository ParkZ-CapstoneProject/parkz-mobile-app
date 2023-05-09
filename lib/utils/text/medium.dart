import 'package:flutter/material.dart';

class MediumText extends StatelessWidget {
  final String text;
  final double fontSize;
  final Color color;
  final int? maxLine;
  final TextAlign? align;

  const MediumText(
      {Key? key,
        required this.text,
        required this.fontSize,
        required this.color, this.maxLine, this.align})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: maxLine,
      textAlign: align,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
          fontSize: fontSize, color: color, fontWeight: FontWeight.w500),
    );
  }
}
