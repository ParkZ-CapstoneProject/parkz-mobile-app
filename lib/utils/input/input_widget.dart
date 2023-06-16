import 'package:flutter/material.dart';
import 'package:parkz/utils/constanst.dart';

class MyInput extends StatelessWidget {
  final String labelText;
  final Color borderColor;
  final bool isMultiLine;
  final bool? isNumber;
  final TextEditingController controller;
  const MyInput({Key? key, required this.labelText, required this.borderColor, required this.controller, required this.isMultiLine, this.isNumber}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Container(
      margin: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 20.0),
      decoration: BoxDecoration(
        border: Border.all(
          color: borderColor,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: TextField(
        keyboardType: isMultiLine == false ? isNumber == false || isNumber == null ? TextInputType.text : TextInputType.number : TextInputType.multiline,
        maxLines: isMultiLine == false ? 1 : null,
        controller: controller,
        style: const TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 15,
          color: AppColor.forText
        ),
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(10.0),
          labelText: labelText,
          labelStyle: const TextStyle(
            color: AppColor.navy,
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
